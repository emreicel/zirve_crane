class UserPolicy < ApplicationPolicy
    def index?
      super_admin? || admin?
    end
  
    def show?
      super_admin? || admin? || record.id == user.id
    end
  
    def create?
      super_admin?
    end
  
    def new?
      create?
    end
  
    def update?
      super_admin? || (admin? && !record.super_admin?) || record == user
    end
  
    def edit?
      update?
    end
  
    def destroy?
      super_admin? && record != user
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
        when 'super_admin'
          scope.all
        when 'admin'
          scope.joins(:role).where.not(roles: { name: 'super_admin' })
        else
          scope.where(id: user.id)
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