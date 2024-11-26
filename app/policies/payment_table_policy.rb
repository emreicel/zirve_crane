class PaymentTablePolicy < ApplicationPolicy
    def index?
      super_admin? || admin? || accountant?
    end
  
    def show?
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