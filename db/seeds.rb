# Örnek vinç bilgileri
cranes = [
  {
    crane_brand_name: 'Zoomlion',
    crane_model_name: '6017-8E',
    crane_chassis_no: '1012T002301598',
    crane_boom_length: 60,  # metre cinsinden
    crane_height: 48,       # metre cinsinden
    crane_tonnage: 8000,     # ton cinsinden
    crane_boom_tonnage: 1700, # ton cinsinden
    crane_year: 2023,
    available: true,
    crane_owner_id: 1
  },
  {
    crane_brand_name: 'Zoomlion',
    crane_model_name: '6017-8E',
    crane_chassis_no: '1012T002301378',
    crane_boom_length: 60,  # metre cinsinden
    crane_height: 60,       # metre cinsinden
    crane_tonnage: 8000,     # ton cinsinden
    crane_boom_tonnage: 1700, # ton cinsinden
    crane_year: 2023,
    available: true,
    crane_owner_id: 1
  },
  {
    crane_brand_name: 'Zoomlion',
    crane_model_name: '6017-8F',
    crane_chassis_no: '1012T002301578',
    crane_boom_length: 65,  # metre cinsinden
    crane_height: 42,       # metre cinsinden
    crane_tonnage: 8000,     # ton cinsinden
    crane_boom_tonnage: 1500, # ton cinsinden
    crane_year: 2023,
    available: true,
    crane_owner_id: 1
  },
  {
    crane_brand_name: 'Zoomlion',
    crane_model_name: '6017-8F',
    crane_chassis_no: '1012T002301520',
    crane_boom_length: 65,  # metre cinsinden
    crane_height: 45,       # metre cinsinden
    crane_tonnage: 8000,     # ton cinsinden
    crane_boom_tonnage: 1500, # ton cinsinden
    crane_year: 2023,
    available: true,
    crane_owner_id: 1
  }
]

# Vinçleri oluştur
cranes.each do |crane_data|
  Crane.find_or_create_by!(crane_chassis_no: crane_data[:crane_chassis_no]) do |crane|
    crane.attributes = crane_data
  end
end

puts "#{Crane.count} adet vinç oluşturuldu"

# Varsayılan rolleri oluştur
default_roles = [
  { name: 'super_admin', description: 'Sistem yöneticisi' },
  { name: 'admin', description: 'Yönetici' },
  { name: 'user', description: 'Normal kullanıcı' },
  { name: 'accountant', description: 'Muhasebeci' }
]

default_roles.each do |role|
  Role.find_or_create_by!(name: role[:name]) do |r|
    r.description = role[:description]
  end
end