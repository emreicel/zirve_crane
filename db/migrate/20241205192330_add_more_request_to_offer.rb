class AddMoreRequestToOffer < ActiveRecord::Migration[7.2]
  def change
    add_reference :price_offers, :crane_fixing, foreign_key: true
    add_column :price_offers, :requested_crane_chassis_size, :string
    add_column :price_offers, :requested_crane_mast_size, :string
  end
end
