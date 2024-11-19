class PaymentMailer < ApplicationMailer
    default from: 'emreicel@gmail.com'  # gönderen email adresini ekleyelim
  
    def payment_notification(payment)
      @payment = payment
      @contract = payment.contract
      
      mail(
        to: @contract.customer.email,
        subject: "Ödeme Bildirimi - #{l(@payment.start_date)}"
      )
    end
  end