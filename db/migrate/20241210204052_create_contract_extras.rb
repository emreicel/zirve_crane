class CreateContractExtras < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_extras do |t|
      t.references :contract, null: false, foreign_key: true
      t.string :contract_extra_description, null: false
      t.decimal :contract_extra_quantity, precision: 10, scale: 2, null: false
      t.string :contract_extra_unit, null: false
      t.decimal :contract_extra_unit_price, precision: 10, scale: 2, null: false
      t.decimal :contract_extra_total_amount, precision: 10, scale: 2, null: false
      t.decimal :contract_extra_total_amount_with_vat, precision: 10, scale: 2, null: false
      t.date :contract_extra_payment_date, null: false
      t.references :payment_method, null: false, foreign_key: true
      t.text :contract_extra_explanation, null: false

      t.timestamps
    end
  end
end