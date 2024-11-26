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

# ... mevcut vinç ve rol kodları ...

# Varsayılan kullanıcıları oluştur
default_users = [
  {
    name: 'Sistem Yöneticisi',
    email: 'emreicel@gmail.com',
    password: '12345678',
    password_confirmation: '12345678',
    role: Role.find_by(name: 'super_admin')
  },
  {
    name: 'Muhasebeci',
    email: 'muhasebe@zirve.com',
    password: 'Zirve123!',
    password_confirmation: 'Zirve123!',
    role: Role.find_by(name: 'accountant')
  },
  {
    name: 'Normal Kullanıcı',
    email: 'kullanici@zirve.com',
    password: 'Zirve123!',
    password_confirmation: 'Zirve123!',
    role: Role.find_by(name: 'user')
  }
]

default_users.each do |user_data|
  user = User.find_or_initialize_by(email: user_data[:email])
  if user.new_record?
    user.assign_attributes(
      name: user_data[:name],
      password: user_data[:password],
      password_confirmation: user_data[:password_confirmation],
      role: user_data[:role]
    )
    user.save!
    puts "#{user.name} kullanıcısı oluşturuldu"
  end
end

puts "#{User.count} adet kullanıcı mevcut"

crane_companies = [
  {
    name: 'Zirve Vinç',
    address: 'Ankara Organize Sanayi Bölgesi 1234. Cadde No: 56',
    phone: '0312 555 44 33',
    email: 'info@zirvevinc.com',
    tax_office: 'Ankara OSB',
    tax_number: '1234567890',
    description: 'Türkiye\'nin önde gelen vinç kiralama şirketi'
  },
  {
    name: 'Anadolu Vinç',
    address: 'İstanbul Dudullu OSB Mahallesi 5. Sokak No: 23',
    phone: '0216 444 55 66',
    email: 'iletisim@anadoluvinc.com',
    tax_office: 'Ümraniye',
    tax_number: '9876543210',
    description: 'Endüstriyel vinç çözümleri'
  },
  {
    name: 'Mega Vinç',
    address: 'İzmir Atatürk OSB 10001 Sokak No: 45',
    phone: '0232 333 22 11',
    email: 'bilgi@megavinc.com',
    tax_office: 'İzmir Konak',
    tax_number: '5678901234',
    description: 'Profesyonel vinç hizmetleri'
  }
]

crane_companies.each do |company_data|
  CraneCompany.find_or_create_by!(tax_number: company_data[:tax_number]) do |company|
    company.attributes = company_data
    puts "#{company.name} firması oluşturuldu"
  end
end

