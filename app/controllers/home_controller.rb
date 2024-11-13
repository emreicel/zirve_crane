# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @payment_records = PaymentTable.all
  end
end
