class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: "Müşteri başarıyla kaydedildi."
    else
      render :new, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "Müşteri başarıyla güncellendi."
    else
      render :edit, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "Müşteri başarıyla silindi."
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:customer_name, :vat_office_name, :customer_address, :customer_phone_number, :email)
  end
end
