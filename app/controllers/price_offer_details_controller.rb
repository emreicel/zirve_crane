class PriceOfferDetailsController < ApplicationController
    before_action :set_price_offer, only: [:create]
    before_action :set_price_offer_detail, only: [:edit, :update, :destroy]
  
    def create
      @price_offer_detail = @price_offer.price_offer_details.build(
        price_offer_list_description: params[:price_offer_list_description],
        price_offer_list_quantity: params[:price_offer_list_quantity],
        price_offer_list_unit: params[:price_offer_list_unit],
        price_offer_detail_unit_price: params[:price_offer_detail_unit_price]
      )
      
      if @price_offer_detail.save
        redirect_to @price_offer, notice: 'Detay başarıyla eklendi.'
      else
        redirect_to @price_offer, alert: 'Detay eklenirken bir hata oluştu.'
      end
    end
  
    def edit
      # Eğer modal kullanıyorsanız bu action'a ihtiyacınız olmayabilir
    end
  
    def update
      if @price_offer_detail.update(price_offer_detail_params)
        redirect_to @price_offer_detail.price_offer, notice: 'Detay başarıyla güncellendi.'
      else
        redirect_to @price_offer_detail.price_offer, alert: 'Detay güncellenirken bir hata oluştu.'
      end
    end
  
    def destroy
      price_offer = @price_offer_detail.price_offer
      @price_offer_detail.destroy
      redirect_to price_offer, notice: 'Detay başarıyla silindi.'
    end
  
    private
  
    def set_price_offer
      @price_offer = PriceOffer.find(params[:price_offer_id])
    end
  
    def set_price_offer_detail
      @price_offer_detail = PriceOfferDetail.find(params[:id])
    end
  
    def price_offer_detail_params
      params.require(:price_offer_detail).permit(
        :price_offer_list_description,
        :price_offer_list_quantity,
        :price_offer_list_unit,
        :price_offer_detail_unit_price
      )
    end
  end