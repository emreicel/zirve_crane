class CreatePriceOfferDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :price_offer_details do |t|
      t.references :price_offer, null: false, foreign_key: true
      t.string :price_offer_list_description
      t.integer :price_offer_list_quantity
      t.string :price_offer_list_unit
      t.float :price_offer_detail_unit_price
      t.float :total_amount

      t.timestamps
    end
  end
end
