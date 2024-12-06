class PriceOfferPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def show?
      true
    end
  
    def create?
      true
    end
  
    def new?
      create?
    end
  
    def update?
      true
    end
  
    def edit?
      update?
    end
  
    def destroy?
      true
    end
  
    def show_pdf?
      true
    end
  
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end