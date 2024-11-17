class Contract < ApplicationRecord
    belongs_to :customer
    belongs_to :crane
    has_many :payment_tables, dependent: :destroy
    accepts_nested_attributes_for :payment_tables

    after_destroy :make_crane_available

    private

    def make_crane_available
        return unless crane.present?

        crane.update(available: true)
    end
end
  