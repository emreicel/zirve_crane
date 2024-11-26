class HomePolicy < ApplicationPolicy
    def show_invoices?
      return false unless user && user.role
      super_admin? || admin?
    end
  
    def show_missing_documents?
      return false unless user && user.role
      super_admin? || admin?
    end
  
    private
  
    def super_admin?
      return false unless user && user.role
      user.role.name == 'super_admin'
    end
  
    def admin?
      return false unless user && user.role
      user.role.name == 'admin'
    end
  
    def accountant?
      return false unless user && user.role
      user.role.name == 'accountant'
    end
  end