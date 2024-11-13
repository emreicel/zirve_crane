class AddAvailableToCranes < ActiveRecord::Migration[7.0]
  def change
    add_column :cranes, :available, :boolean, default: true
  end
end
