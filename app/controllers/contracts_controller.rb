class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contract, only: [:show, :edit, :update, :destroy, :show_pdf, :send_email]
  before_action :set_customers_and_cranes, only: [:new, :edit, :create, :update]
  before_action :set_payment_tables, only: [:show_pdf]

  def index
    authorize Contract
    
    @active_contracts = policy_scope(Contract).where(completed: false)
    @completed_contracts = policy_scope(Contract).where(completed: true)
  
    respond_to do |format|
      format.html
      format.xlsx do
        authorize Contract, :export?
        status = params[:status] || 'all'
        @contracts = case status
                     when 'active'
                       policy_scope(Contract).where(completed: false)
                     when 'completed'
                       policy_scope(Contract).where(completed: true)
                     else
                       policy_scope(Contract)
                     end.order(created_at: :desc)
        
        filename = "contracts_#{status}_#{Time.current.strftime('%Y%m%d')}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  def show
    authorize @contract
    @payment_tables = @contract.payment_tables

    @missing_documents = @contract.payment_tables
      .left_joins(:file_attachment)
      .where(active_storage_attachments: { id: nil })
      .where("start_date < ? OR (start_date >= ? AND start_date <= ?)",
             Date.current,
             Date.current.beginning_of_month,
             Date.current.end_of_month)
      .order(start_date: :asc)
  end

  def new
    @contract = Contract.new
    authorize @contract
    @payment_methods = PaymentMethod.all
  end

  def create
    @contract = Contract.new(contract_params)
    authorize @contract
    
    if @contract.save
      update_crane_availability(@contract.crane_id, false)
      create_payment_tables(@contract)
      redirect_to @contract, notice: "Kontrat başarıyla kaydedildi."
    else
      render :new, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def edit
    authorize @contract
  end

  def update
    authorize @contract
    
    if @contract.update(contract_params)
      update_crane_availability(@contract.crane_id, false)
      @contract.payment_tables.destroy_all
      create_payment_tables(@contract)
      redirect_to @contract, notice: "Kontrat başarıyla güncellendi."
    else
      render :edit, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def destroy
    authorize @contract
    @contract.destroy
    redirect_to contracts_path, notice: "Kontrat başarıyla silindi."
  end

  def complete
    @contract = Contract.find(params[:id])
    authorize @contract, :complete?
    
    if @contract.update(completed: true)
      update_crane_availability(@contract.crane_id, true)
      redirect_to @contract, notice: 'Kontrat başarıyla tamamlandı.'
    else
      redirect_to @contract, alert: 'Kontrat tamamlanırken bir hata oluştu.'
    end
  end

  def show_pdf
    authorize @contract, :show_pdf?
    render pdf: "contract_#{@contract.id}",
           template: "contracts/pdf_template"
  end

  def send_email
    authorize @contract, :send_email?
    
    if @contract.customer&.contact_person_email.present?
      ContractMailer.contract_details(@contract).deliver_later
      redirect_to contracts_path, notice: 'Kontrat detayları email olarak gönderildi.'
    else
      redirect_to contracts_path, alert: 'Müşteri email adresi bulunamadı!'
    end
  rescue StandardError => e
    redirect_to contracts_path, alert: "Email gönderilemedi: #{e.message}"
  end

  private

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def set_customers_and_cranes
    @customers = Customer.all
    @cranes = Crane.where(available: true)
  end

  def set_payment_tables
    @payment_tables = @contract.payment_tables
  end

  def contract_params
    params.require(:contract).permit(:customer_id, :crane_id, :rent_term, 
                                   :rent_amount, :contract_date, :rent_start_date, 
                                   :rent_finish_date, :vat_percentage, :contract_note, :completed)
  end

  def update_crane_availability(crane_id, availability)
    crane = Crane.find_by(id: crane_id)
    crane.update(available: availability) if crane
  end

  def create_payment_tables(contract)
    rent_amount_per_month = (contract.rent_amount.to_f / contract.rent_term).round(2)
    start_date = contract.rent_start_date
  
    contract.rent_term.times do |i|
      PaymentTable.create(
        contract: contract,
        rent_table_quantity: 1,
        start_date: start_date + i.months,
        end_date: start_date + (i + 1).months,
        amount_excluding_vat: rent_amount_per_month,
        vat_percentage: contract.vat_percentage,
        amount_including_vat: rent_amount_per_month * (1 + contract.vat_percentage / 100.0),
        payment_date: nil,
        payment_method: nil
      )
    end
  end
end