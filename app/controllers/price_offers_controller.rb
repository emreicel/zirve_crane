class PriceOffersController < ApplicationController
    before_action :set_price_offer, only: [:show, :edit, :update, :destroy]
  
    def index
      @price_offers = PriceOffer.all
    end
  
    def show
      # @price_offer değişkeni before_action'da set ediliyor
    end
  
    def new
      @price_offer = PriceOffer.new
      @customers = Customer.all
      @payment_methods = PaymentMethod.all
      @cranes = Crane.where(available: true)
    end
  
    def create
      @price_offer = PriceOffer.new(price_offer_params)
      if @price_offer.save
        redirect_to @price_offer, notice: 'Teklif başarıyla oluşturuldu.'
      else
        @customers = Customer.all
        @payment_methods = PaymentMethod.all
        @cranes = Crane.where(available: true)
        render :new
      end
    end
  
    def edit
      @customers = Customer.all
      @payment_methods = PaymentMethod.all
      @cranes = Crane.where(available: true)
      @price_offer = PriceOffer.find(params[:id])
    end
  
    def update
      if @price_offer.update(price_offer_params)
        redirect_to @price_offer, notice: 'Teklif başarıyla güncellendi.'
      else
        @customers = Customer.all
        @payment_methods = PaymentMethod.all
        @cranes = Crane.where(available: true)
        render :edit
      end
    end
  
    def destroy
      @price_offer.destroy
      redirect_to price_offers_path, notice: 'Teklif başarıyla silindi.'
    end
  
    private
  
    def set_price_offer
      @price_offer = PriceOffer.find(params[:id])
    end
  
    def price_offer_params
      params.require(:price_offer).permit(
        :customer_id,
        :price_offer_date,
        :payment_method_id,
        :price_offer_planned_date,
        :crane_id,
        :requested_crane_height,
        :requested_crane_boom_length,
        :requested_crane_tonnage,
        :requested_crane_boom_tonnage
      )
    end

    
  end
