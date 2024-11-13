class AddVatPercentageToContracts < ActiveRecord::Migration[7.2]
  def change
    add_column :contracts, :vat_percentage, :integer
  end
end
