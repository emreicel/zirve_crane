class AddCraneOwnerIdToCranes < ActiveRecord::Migration[7.2]
  def change
    add_column :cranes, :crane_owner_id, :integer
  end
end
