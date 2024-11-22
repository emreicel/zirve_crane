class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role association
  belongs_to :role, optional: true
  
  after_initialize :set_default_role, if: :new_record?

  def super_admin?
    role&.name == 'super_admin'
  end

  def admin?
    role&.name == 'admin'
  end

  def accountant?
    role&.name == 'accountant'
  end

  private

  def set_default_role
    self.role ||= Role.find_by(name: 'user')
  end
end