class CranesController < ApplicationController
  before_action :set_crane, only: [:show, :edit, :update, :destroy]
  before_action :set_crane_owners, only: [:new, :edit]


  def index
    @cranes = Crane.all
    respond_to do |format|
      format.html # varsayılan HTML gösterimi
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="cranes.xlsx"'
      end
    end
  end

  def show
    redirect_to cranes_path
  end

  def new
    @crane = Crane.new
  end

  def create
    @crane = Crane.new(crane_params)
    if @crane.save
      redirect_to cranes_path, notice: "Vinç başarıyla kaydedildi."
    else
      render :new, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def edit
    # @crane değişkeni, set_crane ile ayarlanır
  end

  def update
    if @crane.update(crane_params)
      redirect_to cranes_path, notice: "Vinç başarıyla güncellendi."
    else
      render :edit, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def destroy
    @crane.destroy
    redirect_to cranes_path, notice: "Vinç başarıyla silindi."
  end

  def serial_numbers
    @crane = Crane.find(params[:id])
    render json: { serial_numbers: @crane.serial_numbers }
  end
  

  private

  def set_crane
    @crane = Crane.find(params[:id])
  end

  def set_crane_owners
    @crane_owners = CraneOwner.all
  end

  def crane_params
    params.require(:crane).permit(:crane_brand_name, :crane_model_name, :crane_chassis_no, :crane_boom_length, :crane_height, :crane_tonnage, :crane_boom_tonnage, :crane_year, :crane_owner_id, :available)
  end
end
