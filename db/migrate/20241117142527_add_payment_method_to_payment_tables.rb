class AddPaymentMethodToPaymentTables < ActiveRecord::Migration[7.2]
  def change
    add_column :payment_tables, :payment_method_id, :integer
  end
end
