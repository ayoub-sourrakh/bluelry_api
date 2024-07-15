# app/policies/product_policy.rb
class ProductPolicy < ApplicationPolicy
    def create?
        user.admin?
    end
    
    def update?
        user.admin?
    end
    
    def destroy?
        user.admin?
    end
    
    def show?
        true
    end
end
