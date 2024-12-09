class PaymentMailer < ApplicationMailer
    default from: 'emreicel@gmail.com'  # gönderen email adresini ekleyelim
  
    def payment_notification(payment)
      @payment = payment
      @contract = payment.contract
      @customer = @contract.customer
      
      mail(
        to: ['muhasebe@zirvevinc.tr', 'muhasebe@zirve-vinc.com.tr'],
        cc: ['emre@zirvevinc.tr', 'gokhan@zirvevinc.tr'],
        subject: "#{@contract.contract_number} - Fatura Talebi - #{@payment.start_date&.strftime("%d/%m/%Y")}"
      )
    end
  end