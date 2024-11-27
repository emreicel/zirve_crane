class CraneFixingsController < ApplicationController
  def index
    @crane_fixings = CraneFixing.all
  end

  def show
    @crane_fixing = CraneFixing.find(params[:id])
  end

  def new
    @crane_fixing = CraneFixing.new
  end

  def create
    @crane_fixing = CraneFixing.new(crane_fixing_params)
    if @crane_fixing.save
      redirect_to @crane_fixing, notice: 'Crane fixing başarıyla oluşturuldu.'
    else
      render :new
    end
  end

  def edit
    @crane_fixing = CraneFixing.find(params[:id])
  end

  def update
    @crane_fixing = CraneFixing.find(params[:id])
    if @crane_fixing.update(crane_fixing_params)
      redirect_to @crane_fixing, notice: 'Crane fixing başarıyla güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @crane_fixing = CraneFixing.find(params[:id])
    @crane_fixing.destroy
    redirect_to crane_fixings_url, notice: 'Crane fixing başarıyla silindi.'
  end

  private

  def crane_fixing_params
    params.require(:crane_fixing).permit(:crane_fixing)
  end
end