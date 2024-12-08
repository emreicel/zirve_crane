# Örnek vinç bilgileri
cranes = [
  {
    crane_brand_name: 'ZOOMLION',
    crane_model_name: '6017-8E',
    crane_chassis_no: '1012T002301679',
    crane_boom_length: 60,
    crane_height: 60,
    crane_tonnage: 8000,
    crane_boom_tonnage: 1700,
    crane_year: 2023,
    available: true,
    crane_mast_size: "100 m",
    crane_chassis_size: "100 m",
    crane_owner_id: 1
  },
  {
    crane_brand_name: 'ZOOMLION',
    crane_model_name: '6017-8E',
    crane_chassis_no: '1012T002301598',
    crane_boom_length: 60,
    crane_height: 48,
    crane_tonnage: 8000,
    crane_boom_tonnage: 1700,
    crane_year: 2023,
    available: true,
    crane_mast_size: "100 m",
    crane_chassis_size: "100 m",
    crane_owner_id: 1
  },
  {
    crane_brand_name: 'RAYMONDİ',
    crane_model_name: 'MRT 152',
    crane_chassis_no: '14175',
    crane_boom_length: 65,
    crane_height: 48,
    crane_tonnage: 8000,
    crane_boom_tonnage: 1500,
    crane_year: 2018,
    available: true,
    crane_mast_size: "100 m",
    crane_chassis_size: "100 m",
    crane_owner_id: 1
  },
  {
    crane_brand_name: 'ZOOMLION',
    crane_model_name: '6017-8E',
    crane_chassis_no: '1012T002301577',
    crane_boom_length: 60,
    crane_height: 60,
    crane_tonnage: 8000,
    crane_boom_tonnage: 1700,
    crane_year: 2023,
    available: true,
    crane_mast_size: "100 m",
    crane_chassis_size: "100 m",
    crane_owner_id: 1
  },
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
    name: 'Emre İçel',
    email: 'emreicel@gmail.com',
    password: '12345678',
    password_confirmation: '12345678',
    role: Role.find_by(name: 'super_admin')
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
  }
]

crane_companies.each do |company_data|
  CraneCompany.find_or_create_by!(tax_number: company_data[:tax_number]) do |company|
    company.attributes = company_data
    puts "#{company.name} firması oluşturuldu"
  end
end

