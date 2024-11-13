class Contract < ApplicationRecord
    belongs_to :customer
    belongs_to :crane
    has_many :payment_tables, dependent: :destroy

    after_destroy :make_crane_available

    private

    def make_crane_available
        return unless crane.present?

        crane.update(available: true)
    end
end
  