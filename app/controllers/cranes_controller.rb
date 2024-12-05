class CranesController < ApplicationController
  include Pundit::Authorization
  
  before_action :set_crane, only: [:show, :edit, :update, :destroy, :serial_numbers]
  before_action :set_crane_owners, only: [:new, :edit]

  def index
    @cranes = policy_scope(Crane)
    authorize Crane

    respond_to do |format|
      format.html # varsayılan HTML gösterimi
      format.xlsx do
        authorize Crane, :export?
        response.headers['Content-Disposition'] = 'attachment; filename="cranes.xlsx"'
      end
    end
  end

  def show
    @crane = Crane.find(params[:id])
    authorize @crane
    
    respond_to do |format|
      format.html { redirect_to cranes_path }
      format.json { 
        # Debug için
        Rails.logger.debug "Crane Data: #{@crane.attributes.inspect}"
        Rails.logger.debug "Crane Fixing: #{@crane.crane_fixing.inspect if @crane.crane_fixing}"
        
        render json: {
          crane_fixing: @crane.crane_fixing&.attributes,
          crane_chassis_size: @crane.crane_chassis_size,
          crane_mast_size: @crane.crane_mast_size,
          crane_height: @crane.crane_height,
          crane_boom_length: @crane.crane_boom_length,
          crane_tonnage: @crane.crane_tonnage,
          crane_boom_tonnage: @crane.crane_boom_tonnage
        }
      }
    end
  end

  def new
    @crane = Crane.new
    authorize @crane
  end

  def create
    @crane = Crane.new(crane_params)
    authorize @crane
    
    if @crane.save
      redirect_to cranes_path, notice: "Vinç başarıyla kaydedildi."
    else
      set_crane_owners
      render :new, status: :unprocessable_entity, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def edit
    authorize @crane
  end

  def update
    authorize @crane
    
    if @crane.update(crane_params)
      redirect_to cranes_path, notice: "Vinç başarıyla güncellendi."
    else
      set_crane_owners
      render :edit, status: :unprocessable_entity, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def destroy
    authorize @crane
    @crane.destroy
    redirect_to cranes_path, notice: "Vinç başarıyla silindi."
  end

  def serial_numbers
    authorize @crane, :show?
    render json: { serial_numbers: @crane.serial_numbers }
  end

  def info
    crane = Crane.find(params[:id])
    render json: {
    crane_height: crane.crane_height,
    crane_boom_length: crane.crane_boom_length,
    crane_tonnage: crane.crane_tonnage
    }
  end

  private

  def set_crane
    @crane = Crane.find(params[:id])
  end

  def set_crane_owners
    @crane_owners = CraneOwner.all
  end

  def crane_params
    params.require(:crane).permit(
      :crane_brand_name, 
      :crane_model_name, 
      :crane_chassis_no, 
      :crane_boom_length, 
      :crane_height, 
      :crane_tonnage, 
      :crane_boom_tonnage, 
      :crane_year, 
      :crane_owner_id, 
      :available
    )
  end

  def pundit_user
    current_user
  end

  def user_not_authorized
    flash[:alert] = "Bu işlemi yapmaya yetkiniz yok."
    redirect_to(request.referrer || cranes_path)
  end
end