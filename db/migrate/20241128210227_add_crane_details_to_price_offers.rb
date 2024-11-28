class AddCraneDetailsToPriceOffers < ActiveRecord::Migration[7.2]
  def change
    add_reference :price_offers, :crane, foreign_key: true
    add_column :price_offers, :requested_crane_height, :decimal
    add_column :price_offers, :requested_crane_boom_length, :decimal
    add_column :price_offers, :requested_crane_tonnage, :decimal
    add_column :price_offers, :requested_crane_boom_tonnage, :string
  end
end
