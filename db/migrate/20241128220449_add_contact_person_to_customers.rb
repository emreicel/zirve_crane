class AddContactPersonToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :contact_person_name, :string
    add_column :customers, :contact_person_phone, :string
    add_column :customers, :contact_person_email, :string
  end
end
