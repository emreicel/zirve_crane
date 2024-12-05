class PriceOfferDetail < ApplicationRecord
    belongs_to :price_offer
  
    validates :price_offer_list_description, presence: true
    validates :price_offer_list_quantity, presence: true, numericality: { greater_than: 0 }
    validates :price_offer_list_unit, presence: true
    validates :price_offer_detail_unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    before_save :calculate_total_amount
  
    private
  
    def calculate_total_amount
      if price_offer_list_quantity.present? && price_offer_detail_unit_price.present?
        self.total_amount = price_offer_list_quantity * price_offer_detail_unit_price
      end
    end
  end