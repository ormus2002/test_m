# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_if_admin,  only: [:edit, :update, :destroy]
  before_filter :check_roles_groups, only: :update

  def index
    if manager?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['manager_id = ? OR id = ?', current_user.id, current_user.id])
    elsif worker?(current_user)
      @users = current_user
    elsif bux?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['visible_for_bux = ? OR id = ?', true, current_user.id])
    else
      @users = User.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Профиль успешно обновлен"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален."
    redirect_to users_path
  end

  private
    def check_roles_groups
      role_t = Role.find(params[:user][:role_id])
      group_t = Group.find(params[:user][:group_id])
      if (group_t.builtin == 1) && (role_t.builtin == 3 || role_t.builtin == 5)
        flash[:error] = "#{role_t.name} не может иметь доступ в группу #{group_t.name}."
        @user = User.find(params[:id])
        render 'edit'
      end
      if (group_t.builtin == 2) && (role_t.builtin == 2)
        flash[:error] = "#{role_t.name} не может иметь доступ в группу #{group_t.name}."
        @user = User.find(params[:id])
        render 'edit'
      end
    end
end
