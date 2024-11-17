class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy, :show_pdf]
  before_action :set_customers_and_cranes, only: [:new, :edit, :create, :update]
  before_action :set_payment_tables, only: [:show_pdf]

  def index
    @contracts = Contract.all

    respond_to do |format|
      format.html # Varsayılan HTML görünümü
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="contracts.xlsx"'
      end
    end
  end

  def show
    @contract = Contract.find(params[:id])
    @payment_tables = @contract.payment_tables
  end

  def new
    @contract = Contract.new
    @payment_methods = PaymentMethod.all
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      update_crane_availability(@contract.crane_id, false)
      #create_payment_schedule(@contract)
      create_payment_tables(@contract)
      redirect_to @contract, notice: "Kontrat başarıyla kaydedildi."
    else
      render :new, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def edit
  end

  def update
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
    @contract.destroy
    redirect_to contracts_path, notice: "Kontrat başarıyla silindi."
  end

  def show_pdf
    render pdf: "contract_#{@contract.id}", # PDF dosya adı
           template: "contracts/pdf_template" # Kullanılacak şablon dosyası
  end

  # app/controllers/contracts_controller.rb
  def send_email
    @contract = Contract.find(params[:id])
    begin
      ContractMailer.payment_notification(@contract).deliver_now
      flash[:notice] = "E-posta başarıyla gönderildi."
    rescue => e
      Rails.logger.error "E-posta gönderim hatası: #{e.message}"
      flash[:alert] = "E-posta gönderilirken bir hata oluştu: #{e.message}"
    end
    redirect_to contracts_path
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

  def update_payment_tables(contract, payment_params)
    payment_params.each do |index, payment_data|
      payment = contract.payment_tables[index.to_i]
      payment.update(payment_date: payment_data[:payment_date], payment_method: payment_data[:payment_method])
    end
  end

  def contract_params
    params.require(:contract).permit(:customer_id, :crane_id, :rent_term, :rent_amount, :contract_date, :rent_start_date, :rent_finish_date, :vat_percentage)
  end

  def update_crane_availability(crane_id, availability)
    crane = Crane.find_by(id: crane_id)
    crane.update(available: availability) if crane
  end

  def create_payment_tables(contract)
    rent_amount_per_month = contract.rent_amount / contract.rent_term
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
