class CreateContracts < ActiveRecord::Migration[7.2]
  def change
    create_table :contracts do |t|
      t.integer :customer_id
      t.integer :crane_id
      t.integer :rent_term
      t.integer :rent_amount
      t.date :contract_date
      t.date :rent_start_date
      t.date :rent_finish_date

      t.timestamps
    end
  end
end
