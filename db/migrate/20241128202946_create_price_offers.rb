class CreatePriceOffers < ActiveRecord::Migration[7.2]
  def change
    create_table :price_offers do |t|
      t.references :customer, null: false, foreign_key: true
      t.date :price_offer_date
      t.references :payment_method, null: false, foreign_key: true
      t.date :price_offer_planned_date

      t.timestamps
    end
  end
end
