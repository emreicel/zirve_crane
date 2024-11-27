class Bank < ApplicationRecord
    validates :bank_name, presence: true
    validates :branch_name, presence: true
    validates :currency, presence: true
    validates :iban_no, presence: true, uniqueness: true
    
    CURRENCIES = ['TRY', 'USD', 'EUR', 'GBP'].freeze
  end