class CraneOwner < ApplicationRecord
    has_many :cranes, dependent: :destroy
end
