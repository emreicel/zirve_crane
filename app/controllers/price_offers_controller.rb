class PriceOffersController < ApplicationController
  before_action :set_price_offer, only: [:show, :edit, :update, :show_pdf, :destroy]
  before_action :set_collections, only: [:new, :create, :edit, :update]


  def index
    @price_offers = PriceOffer.all
  end

  def show
    @crane_fixings = CraneFixing.all
    @price_offer_details = @price_offer.price_offer_details
  end

  def new
    @price_offer = PriceOffer.new
    @price_offer.price_offer_details.build # Yeni bir detay satırı için
    @customers = Customer.all
    @payment_methods = PaymentMethod.all
    @cranes = Crane.all
    @crane_fixings = CraneFixing.all
  
    respond_to do |format|
      format.html
      format.json do
        crane = Crane.find(params[:crane_id])
        render json: {
          crane_fixing: crane.crane_fixing&.crane_fixing,
          crane_chassis_size: crane.crane_chassis_size,
          crane_mast_size: crane.crane_mast_size,
          crane_height: crane.crane_height,
          crane_boom_length: crane.crane_boom_length,
          crane_tonnage: crane.crane_tonnage,
          crane_boom_tonnage: crane.crane_boom_tonnage
        }
      end
    end
  end

  def create
    @price_offer = PriceOffer.new(price_offer_params)
    
    if @price_offer.save
      redirect_to @price_offer, notice: 'Teklif başarıyla oluşturuldu.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @price_offer.update(price_offer_params)
      redirect_to @price_offer, notice: 'Teklif başarıyla güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @price_offer.destroy
    redirect_to price_offers_path, notice: 'Teklif başarıyla silindi.'
  end

  def show_pdf
    @price_offer = PriceOffer.find(params[:id])
    
    respond_to do |format|
      format.pdf do
        render pdf: "teklif_#{@price_offer.id}",
               template: "price_offers/show_pdf",
               layout: false,
               disposition: "inline",
               page_size: "A4",
               margin: {
                 top: 20,
                 bottom: 20,
                 left: 20,
                 right: 20
               }
      end
    end
  end

  

  private

  def set_price_offer
    @price_offer = PriceOffer.find(params[:id])
  end

  def set_collections
    @customers = Customer.all
    @payment_methods = PaymentMethod.all
    @cranes = Crane.where(available: true)
    @crane_fixings = CraneFixing.all
  end

  def get_crane_info
    crane = Crane.find(params[:crane_id])
    
    render json: {
      crane_fixing: crane.crane_fixing&.crane_fixing,
      crane_chassis_size: crane.crane_chassis_size,
      crane_mast_size: crane.crane_mast_size,
      crane_height: crane.crane_height,
      crane_boom_length: crane.crane_boom_length,
      crane_tonnage: crane.crane_tonnage,
      crane_boom_tonnage: crane.crane_boom_tonnage
    }
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
      :requested_crane_boom_tonnage,
      :crane_fixing_id,
      :requested_crane_chassis_size,
      :requested_crane_mast_size,
      price_offer_details_attributes: [
        :id,
        :price_offer_list_description,
        :price_offer_list_quantity,
        :price_offer_list_unit,
        :price_offer_detail_unit_price,
        :total_amount,
        :_destroy
      ]
    )
  end

end