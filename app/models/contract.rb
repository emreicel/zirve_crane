class Contract < ApplicationRecord
    belongs_to :customer
    belongs_to :crane
    has_many :payment_tables, dependent: :destroy
    accepts_nested_attributes_for :payment_tables
  
    after_commit :generate_contract_number, on: :create
    after_destroy :make_crane_available
  
    private
  
    def generate_contract_number
      return if contract_number.present?
      
      date_part = Date.today.strftime('%y%m%d')
      sequence = id.to_s.rjust(6, '0')
      update_column(:contract_number, "KON-#{date_part}#{sequence}")
    end
  
    def make_crane_available
      return unless crane.present?
      crane.update(available: true)
    end
  end