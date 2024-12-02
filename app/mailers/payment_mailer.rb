class PaymentMailer < ApplicationMailer
    default from: 'emreicel@gmail.com'  # gönderen email adresini ekleyelim
  
    def payment_notification(payment)
      @payment = payment
      @contract = payment.contract
      @customer = @contract.customer
    
      Rails.logger.debug "PaymentMailer Debug:"
      Rails.logger.debug "Payment: #{@payment.inspect}"
      Rails.logger.debug "Contract: #{@contract.inspect}"
      Rails.logger.debug "Customer: #{@customer.inspect}"
      Rails.logger.debug "To Email: #{@customer.email}"

      raise "Customer email is missing" if @customer.contact_person_email.blank?
      
      mail(
        to: [@contract.customer.contact_person_email],
        subject: "#{@contract.contract_number} - Fatura Talebi - #{@payment.start_date&.strftime("%d/%m/%Y")}"
      )
    end
  end