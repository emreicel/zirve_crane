class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.includes(:role).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to users_path, notice: 'Kullanıcı başarıyla oluşturuldu.'
    else
      flash.now[:alert] = 'Kullanıcı oluşturulurken bir hata oluştu.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if updating_password?
      if @user.update(user_params)
        redirect_to users_path, notice: 'Kullanıcı başarıyla güncellendi.'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      if @user.update(user_params_without_password)
        redirect_to users_path, notice: 'Kullanıcı başarıyla güncellendi.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: 'Kendinizi silemezsiniz.'
    else
      @user.destroy
      redirect_to users_path, notice: 'Kullanıcı başarıyla silindi.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_super_admin
    unless current_user&.super_admin?
      redirect_to root_path, alert: 'Bu işlemi yapmaya yetkiniz yok.'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  end

  def user_params_without_password
    params.require(:user).permit(:name, :email, :role_id)
  end

  def updating_password?
    params[:user][:password].present? || params[:user][:password_confirmation].present?
  end
end