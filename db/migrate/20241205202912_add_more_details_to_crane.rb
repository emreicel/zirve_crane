class AddMoreDetailsToCrane < ActiveRecord::Migration[7.2]
  def change
    add_column :cranes, :crane_mast_size, :string
    add_column :cranes, :crane_chassis_size, :string
  end
end
