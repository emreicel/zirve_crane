class CustomerInvoiceRequestMailer < ApplicationMailer
    default from: 'emreicel@gmail.com' # Kendi e-posta adresinizi kullanabilirsiniz

  def send_customer_invoice_request_info(payment)
    @customer_invoice_request = customer_invoice_request
    mail(to: 'emre@zirvevinc.tr', subject: 'Fatura Talebi') # E-posta adresini değiştirmelisiniz
  end
end
