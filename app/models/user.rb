class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role, optional: true
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  after_initialize :set_default_role, if: :new_record?

  ROLE_PRIORITIES = {
    'super_admin' => 1,
    'admin' => 2,
    'accountant' => 3,
    'user' => 4
  }

  def super_admin?
    role&.name == 'super_admin'
  end

  def admin?
    role&.name == 'admin'
  end

  def accountant?
    role&.name == 'accountant'
  end

  def has_permission?(required_role)
    return false unless role
    ROLE_PRIORITIES[role.name] <= ROLE_PRIORITIES[required_role.to_s]
  end

  private

  def set_default_role
    self.role ||= Role.find_by(name: 'user')
  end
end