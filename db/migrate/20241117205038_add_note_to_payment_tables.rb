class AddNoteToPaymentTables < ActiveRecord::Migration[7.2]
  def change
    add_column :payment_tables, :note, :text
  end
end
