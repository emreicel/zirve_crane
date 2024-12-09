class Contract < ApplicationRecord
    belongs_to :customer
    belongs_to :crane
    has_many :payment_tables, dependent: :destroy
    accepts_nested_attributes_for :payment_tables
    has_many :contract_extras, dependent: :destroy
    accepts_nested_attributes_for :contract_extras, allow_destroy: true
  
    after_commit :generate_contract_number, on: :create
    after_destroy :make_crane_available

    validates :contract_note, length: { maximum: 1000 } # Maksimum 1000 karakter
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

  def set_finish_date
    return unless rent_start_date.present? && rent_term.present?
    
    # Bitiş tarihini ayın son günü olarak ayarla
    self.rent_finish_date = rent_start_date.advance(months: rent_term)
  end