# -*- encoding : utf-8 -*-
class GroupsController < ApplicationController

  before_filter :authenticate_user!, :check_if_role
  before_filter :check_if_admin, except: [:index, :show]
  before_filter :check_if_builtin,  only: [:edit, :update, :destroy]
  before_filter :find_group,  only: [:show]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
  end

  def edit
  end

  def update
    if @group.update_attributes(params[:group])
      flash[:success] = "Группа успешно обновлена"
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = "Группа успешно создана"
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Группа удалена."
    redirect_to groups_path
  end

  private
    def find_group
      @group = Group.where(id: params[:id]).first
      render_404 unless @group 
    end
    
    def check_if_builtin
      find_group
      render_403 unless @group.builtin == 0
    end

end
