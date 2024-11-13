class CreatePaymentTables < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_tables do |t|
      t.references :contract, null: false, foreign_key: true
      t.integer :rent_table_quantity
      t.date :start_date
      t.date :end_date
      t.decimal :amount_excluding_vat
      t.decimal :vat_percentage
      t.decimal :amount_including_vat
      t.date :payment_date
      t.string :payment_method

      t.timestamps
    end
  end
end
