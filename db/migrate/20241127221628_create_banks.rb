class CreateBanks < ActiveRecord::Migration[7.2]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :branch_name
      t.string :currency
      t.string :iban_no
      t.string :swift_no

      t.timestamps
    end
  end
end
