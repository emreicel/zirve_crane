class AddNoteToContracts < ActiveRecord::Migration[7.2]
  def change
    add_column :contracts, :contract_note, :text
  end
end
