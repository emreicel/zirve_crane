class PaymentMethod < ApplicationRecord
    has_many :payment_tables
    has_many :contract_extras
    validates :payment_method, presence: true
  end