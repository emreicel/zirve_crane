class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Kullanıcı başarıyla oluşturuldu.'
    else
      render :new, alert: 'Kullanıcı oluşturulurken bir hata oluştu.'
    end
  end
  
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'Kullanıcı başarıyla güncellendi.'
    else
      render :edit
    end
  end

  private

  def authorize_super_admin
    redirect_to root_path, alert: 'Bu işlemi yapmaya yetkiniz yok.' unless current_user&.super_admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
