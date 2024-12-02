class AddCompletedToContract < ActiveRecord::Migration[7.2]
  def change
    add_column :contracts, :completed, :boolean, default: false
  end
end
