class Role < ApplicationRecord
  has_many :users
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  AVAILABLE_ROLES = %w[super_admin admin accountant user]

  def self.seed_default_roles
    AVAILABLE_ROLES.each do |role_name|
      find_or_create_by!(name: role_name) do |role|
        role.description = role_name.titleize
      end
    end
  end
end