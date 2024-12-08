class Crane < ApplicationRecord
    has_many :contracts
    belongs_to :crane_owner, optional: true
    paginates_per 10
end
  