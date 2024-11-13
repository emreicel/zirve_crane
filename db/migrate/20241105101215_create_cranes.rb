class CreateCranes < ActiveRecord::Migration[7.2]
  def change
    create_table :cranes do |t|
      t.string :crane_brand_name
      t.string :crane_model_name
      t.string :crane_chassis_no
      t.integer :crane_boom_length
      t.integer :crane_height
      t.integer :crane_tonnage
      t.integer :crane_boom_tonnage
      t.integer :crane_year
      t.string :crane_company_name

      t.timestamps
    end
  end
end
