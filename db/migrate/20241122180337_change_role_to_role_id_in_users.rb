class ChangeRoleToRoleIdInUsers < ActiveRecord::Migration[7.0]
  def up
    # Geçici olarak eski rolleri saklamak için
    add_column :users, :old_role, :integer
    
    # Mevcut rolleri yedekle
    execute "UPDATE users SET old_role = role"
    
    # role sütununu kaldır
    remove_column :users, :role
    
    # Yeni role_id sütununu ekle
    add_column :users, :role_id, :integer
    add_index :users, :role_id
    
    # Varsayılan rolleri oluştur
    reversible do |dir|
      dir.up do
        Role.create([
          { name: 'user', description: 'Normal Kullanıcı' },
          { name: 'admin', description: 'Yönetici' },
          { name: 'super_admin', description: 'Süper Yönetici' },
          { name: 'accountant', description: 'Muhasebeci' }
        ])
        
        # Eski rolleri yeni role_id'lere dönüştür
        execute <<-SQL
          UPDATE users SET role_id = (
            CASE old_role 
              WHEN 0 THEN (SELECT id FROM roles WHERE name = 'user')
              WHEN 1 THEN (SELECT id FROM roles WHERE name = 'admin')
              WHEN 2 THEN (SELECT id FROM roles WHERE name = 'super_admin')
              WHEN 3 THEN (SELECT id FROM roles WHERE name = 'accountant')
            END
          )
        SQL
      end
    end
    
    # Geçici sütunu kaldır
    remove_column :users, :old_role
  end

  def down
    add_column :users, :role, :integer
    remove_column :users, :role_id
  end
end