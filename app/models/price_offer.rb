class PriceOffer < ApplicationRecord
  belongs_to :customer
  belongs_to :payment_method
  belongs_to :crane, optional: true

  validates :price_offer_date, presence: true
  validates :price_offer_planned_date, presence: true
end