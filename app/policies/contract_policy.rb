class ContractPolicy < ApplicationPolicy
    def index?
      super_admin? || admin? || accountant?
    end
  
    def show?
      super_admin? || admin? || accountant?
    end
  
    def create?
      super_admin? || admin?
    end
  
    def new?
      create?
    end
  
    def update?
      super_admin? || admin?
    end
  
    def edit?
      update?
    end
  
    def destroy?
      super_admin? || admin?
    end
  
    def show_pdf?
      super_admin? || admin? || accountant?
    end
  
    def send_email?
      super_admin? || admin?
    end
  
    def export?
      super_admin? || admin? || accountant?
    end
  
    class Scope
      attr_reader :user, :scope
  
      def initialize(user, scope)
        @user = user
        @scope = scope
      end
  
      def resolve
        return scope.none unless user && user.role
  
        case user.role.name
        when 'super_admin', 'admin'
          scope.all
        when 'accountant'
          scope.all
        else
          scope.none
        end
      end
    end

    def send_email?
        super_admin? || admin?  # Sadece super_admin ve admin email gönderebilir
    end

    def show_pdf?
        super_admin? || admin?  # accountant kaldırıldı
    end

    def show_info?
        super_admin? || admin?  # Sadece super_admin ve admin info görüntüleyebilir
    end
  
    private
  
    def super_admin?
      user.role.name == 'super_admin'
    end
  
    def admin?
      user.role.name == 'admin'
    end
  
    def accountant?
      user.role.name == 'accountant'
    end

    
  end