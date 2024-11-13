class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, admin: 1, super_admin: 2 }
  # Varsayılan olarak her yeni kullanıcı "user" rolüne sahip olur
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :super_admin
  end
end
