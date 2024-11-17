class PaymentMethod < ApplicationRecord
    has_many :payment_tables
    
    validates :payment_method, presence: true
  end