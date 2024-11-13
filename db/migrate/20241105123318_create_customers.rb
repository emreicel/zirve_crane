class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.string :vat_office_name
      t.text :customer_address
      t.string :customer_phone_number

      t.timestamps
    end
  end
end
