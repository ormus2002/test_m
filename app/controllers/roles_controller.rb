class RolesController < ApplicationController
  before_filter :check_if_admin
  
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def show
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    if @role.update_attributes(params[:role])
      flash[:success] = "Роль успешно обновлена"
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      flash[:success] = "Роль успешно создана"
      redirect_to roles_path
    else
      render 'new'
    end
  end

end
