class AddEmailSentAtToPaymentTables < ActiveRecord::Migration[7.2]
  def change
    add_column :payment_tables, :email_sent_at, :datetime
  end
end
