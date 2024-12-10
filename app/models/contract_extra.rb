class ContractExtra < ApplicationRecord
    belongs_to :contract
    belongs_to :payment_method, optional: true
  
    validates :contract_extra_description, presence: true
    validates :contract_extra_quantity, presence: true, numericality: { greater_than: 0 }
    validates :contract_extra_unit, presence: true
    validates :contract_extra_unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :contract_extra_total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :contract_extra_total_amount_with_vat, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :contract_extra_payment_date, presence: true
    validates :contract_extra_payment_method, presence: true
    validates :contract_extra_explanation, presence: true
  
    before_save :calculate_total_amount
  
    private
  
    def calculate_total_amount
      if contract_extra_quantity.present? && contract_extra_unit_price.present?
        self.total_amount = contract_extra_quantity * contract_extra_unit_price
      end
    end
  end