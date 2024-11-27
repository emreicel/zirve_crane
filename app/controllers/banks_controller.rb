class BanksController < ApplicationController
  before_action :set_bank, only: [:edit, :update, :destroy]

  def index
    @banks = Bank.all

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="banka_hesaplari.xlsx"'
      }
    end
  end

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to banks_path, notice: 'Banka başarıyla oluşturuldu.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bank.update(bank_params)
      redirect_to banks_path, notice: 'Banka başarıyla güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    @bank.destroy
    redirect_to banks_path, notice: 'Banka başarıyla silindi.'
  end

  private

  def set_bank
    @bank = Bank.find(params[:id])
  end

  def bank_params
    params.require(:bank).permit(:bank_name, :branch_name, :currency, :iban_no, :swift_no)
  end
end