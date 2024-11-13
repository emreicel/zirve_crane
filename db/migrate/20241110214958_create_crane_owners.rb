class CreateCraneOwners < ActiveRecord::Migration[7.2]
  def change
    create_table :crane_owners do |t|
      t.string :crane_owner_name
      t.text :crane_owner_address
      t.string :crane_owner_phone
      t.string :crane_owner_vat_office
      t.string :crane_owner_contact
      t.string :crane_owner_contact_email
      t.string :crane_owner_contact_phone

      t.timestamps
    end
  end
end
