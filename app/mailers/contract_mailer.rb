class ContractMailer < ApplicationMailer
    default from: 'emreicel@gmail.com'
  
    def payment_notification(contract)
      @contract = contract
      mail(to: 'emre@iclexport.com', subject: 'Fatura Talebi')do |format|
        format.html { render 'payment_notification' }
      end

    # Sunucu yanıtını günlüğe yazdırma
      Rails.logger.info "E-posta gönderimi için hazırlanan: #{message}"
    end
  end
  