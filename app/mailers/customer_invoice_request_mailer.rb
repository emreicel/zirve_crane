class CustomerInvoiceRequestMailer < ApplicationMailer
  default from: 'emreicel@gmail.com'

  def send_customer_invoice_request_info(payment)
    @customer_invoice_request = customer_invoice_request
    
    accountant_emails = User.accountant.where.not(email: nil).pluck(:email)
    # Eğer accountant e-postası yoksa varsayılan adres kullan
    accountant_emails = ['muhasebe@zirvevinc.tr'] if accountant_emails.empty?

    mail(
      to: accountant_emails,
      cc: ['emre@zirvevinc.tr', 'gokhan@zirvevinc.tr'],
      subject: 'Fatura Talebi'
    )
  end
end