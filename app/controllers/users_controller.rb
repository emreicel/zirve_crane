class UsersController < ApplicationController
  include Pundit::Authorization
  
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @users = policy_scope(User).includes(:role)
    authorize User
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    
    # Yeni kullanıcı için otomatik şifre oluştur
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    @user.password_confirmation = generated_password
    
    if @user.save
      redirect_to users_path, notice: "Kullanıcı başarıyla oluşturuldu. Geçici şifre: #{generated_password}"
    else
      flash.now[:alert] = 'Kullanıcı oluşturulurken bir hata oluştu.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  
    if @user.update(user_params)
      redirect_to users_path, notice: 'Kullanıcı başarıyla güncellendi.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user
    
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

  def user_params
    if params[:user][:password].present?
      params.require(:user).permit(:name, :email, :role_id, :password, :password_confirmation)
    else
      params.require(:user).permit(:name, :email, :role_id)
    end
  end

  def user_not_authorized
    redirect_to root_path, alert: 'Bu işlemi yapmaya yetkiniz yok.'
  end
end