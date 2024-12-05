class PriceOffer < ApplicationRecord
  belongs_to :customer
  belongs_to :payment_method
  belongs_to :crane, optional: true
  belongs_to :crane_fixing, optional: true
  has_many :price_offer_details, dependent: :destroy
  accepts_nested_attributes_for :price_offer_details, allow_destroy: true

  validates :price_offer_date, presence: true
  validates :price_offer_planned_date, presence: true
end