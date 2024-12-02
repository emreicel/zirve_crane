class AddCompletedToContract < ActiveRecord::Migration[7.2]
  def change
    add_column :contracts, :completed, :boolean, default: false
    add_column :contracts, :contract_requested_crane_boom_length, :integer
    add_column :contracts, :contract_requested_crane_height, :integer
    add_column :contracts, :contract_requested_crane_tonnage, :integer
    add_column :contracts, :contract_requested_crane_boom_tonnage, :integer
  end
end

