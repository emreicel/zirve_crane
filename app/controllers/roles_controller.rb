class RolesController < ApplicationController
  before_action :require_super_admin
  before_action :set_role, only: [:edit, :update, :destroy]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: 'Rol başarıyla oluşturuldu.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to roles_path, notice: 'Rol başarıyla güncellendi.'
    else
      render :edit
    end
  end

  def destroy
    if @role.users.exists?
      redirect_to roles_path, alert: 'Bu role sahip kullanıcılar var. Önce kullanıcıların rollerini değiştirin.'
    else
      @role.destroy
      redirect_to roles_path, notice: 'Rol başarıyla silindi.'
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :description)
  end

  def require_super_admin
    unless current_user&.super_admin?
      redirect_to root_path, alert: 'Bu sayfaya erişim yetkiniz yok.'
    end
  end
end