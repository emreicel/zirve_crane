class CreateCraneFixings < ActiveRecord::Migration[7.2]
  def change
    create_table :crane_fixings do |t|
      t.string :crane_fixing

      t.timestamps
    end
  end
end
