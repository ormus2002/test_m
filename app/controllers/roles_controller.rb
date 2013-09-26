# -*- encoding : utf-8 -*-
class RolesController < ApplicationController
  before_filter :check_if_admin
  before_filter :check_if_builtin,  only: [:edit, :update, :destroy]

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

  def destroy
    Role.find(params[:id]).destroy
    flash[:success] = "Роль удалена."
    redirect_to roles_path
  end

  private
    def check_if_builtin
      @role = Role.find(params[:id])       
      render_403 unless @role.builtin == 0
    end
end
