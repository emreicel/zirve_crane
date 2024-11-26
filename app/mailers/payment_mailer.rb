class PaymentMailer < ApplicationMailer
    default from: 'emreicel@gmail.com'  # gönderen email adresini ekleyelim
  
    def payment_notification(payment)
      @payment = payment
      @contract = payment.contract
      
      mail(
        to: [@contract.customer.email, 'gokhanyard@gmail.com'],
        subject: "#{@contract.contract_number} - Fatura Talebi - #{l(@payment.start_date)}"
      )
    end
  end