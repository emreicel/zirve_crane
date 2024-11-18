class Customer < ApplicationRecord
    has_many :contracts
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
  