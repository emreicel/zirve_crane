class ContractExtrasController < ApplicationController
    before_action :set_contract, only: [:create]
    before_action :set_contract_extra, only: [:edit, :update, :destroy]
  
    def create
      @contract_extra = @contract.contract_extras.build(
        contract_extra_description: params[:contract_extra_description],
        contract_extra_quantity: params[:contract_extra_quantity],
        contract_extra_unit: params[:contract_extra_unit],
        contract_extra_unit_price: params[:contract_extra_unit_price],
        contract_extra_total_amount: params[:contract_extra_total_amount],
        contract_extra_total_amount_with_vat: params[:contract_extra_total_amount_with_vat],
        contract_extra_payment_date: params[:contract_extra_payment_date],
        contract_extra_payment_method: params[:contract_extra_payment_method],
        contract_extra_explanation: params[:contract_extra_explanation]
      )
      
      if @contract_extra.save
        redirect_to @contract, notice: 'Detay başarıyla eklendi.'
      else
        redirect_to @contract, alert: 'Detay eklenirken bir hata oluştu.'
      end
    end
  
    def edit
      # Eğer modal kullanıyorsanız bu action'a ihtiyacınız olmayabilir
    end
  
    def update
      if @contract_extra.update(contract_extra_params)
        redirect_to @contract_extra.contract, notice: 'Detay başarıyla güncellendi.'
      else
        redirect_to @contract_extra.contract, alert: 'Detay güncellenirken bir hata oluştu.'
      end
    end
  
    def destroy
      contract = @contract_extra.contract
      @contract_extra.destroy
      redirect_to contract, notice: 'Detay başarıyla silindi.'
    end
  
    private
  
    def set_contract
      @contract = Contract.find(params[:contract_id])
    end
  
    def set_contract_extra
      @contract_extra = ContractExtra.find(params[:id])
    end
  
    def contract_extra_params
      params.require(:contract_extra).permit(
        :contract_extra_description,
        :contract_extra_quantity,
        :contract_extra_unit,
        :contract_extra_unit_price,
        :contract_extra_total_amount,
        :contract_extra_total_amount_with_vat,
        :contract_extra_payment_date,
        :contract_extra_payment_method,
        :contract_extra_explanation
      )
    end
  end