class ContractMailer < ApplicationMailer
  def contract_details(contract)
    @contract = contract
    @customer = contract.customer
    @crane = contract.crane

    attachments["kontrat_#{contract.id}.pdf"] = contract.generate_pdf if contract.respond_to?(:generate_pdf)
    
    mail(
      to: @customer.email,
      subject: "Vinç Kiralama Kontrat Detayları - ##{contract.id}"
    )
  end
end