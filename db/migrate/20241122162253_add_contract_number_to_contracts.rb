class AddContractNumberToContracts < ActiveRecord::Migration[7.2]
  def change
    add_column :contracts, :contract_number, :string
    add_index :contracts, :contract_number, unique: true
  end
end
