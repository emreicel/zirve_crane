class CranePolicy < ApplicationPolicy
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
  
    class Scope
      attr_reader :user, :scope
      
      def initialize(user, scope)
        @user = user
        @scope = scope
      end
  
      def resolve
        return scope.none unless user && user.role
  
        case user.role.name
        when 'super_admin', 'admin', 'accountant'
          scope.all
        else
          scope.none
        end
      end
    end

    def export?
      super_admin? || admin?  # veya istediğiniz yetki kontrolü
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