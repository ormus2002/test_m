# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_if_admin,  only: :destroy
  before_filter :check_roles_groups, only: :update
  before_filter :check_if_admin_or_manager, only: [:edit, :update]

  def index
    if manager?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['manager_id = ? OR id = ?', current_user.id, current_user.id])
    elsif worker?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['id = ?', current_user.id])
    elsif bux?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['visible_for_bux = ? OR id = ?', true, current_user.id])
    elsif admin?(current_user)
      @users = User.paginate(page: params[:page])
    else
      render_403
    end
    @users = @users.includes([:role, :group])
  end

  def show
    user = User.find(params[:id])
    if current_user?(user) || admin?(current_user)
      @user = user
    elsif manager?(current_user) && (user.manager_id == current_user.id)
      @user = user
    elsif bux?(current_user) && (user.visible_for_bux)
      @user = user
    else
      render_403
    end
  end

  def edit
    @user = User.find(params[:id])
    if admin?(current_user)
      render 'users/edit'
    else
      render 'users/edit_by_manager'
    end
  end

  def update
    @user = User.find(params[:id])
    if manager?(current_user)
      update_by_manager
    else
      if @user.update_attributes(params[:user])
        flash[:success] = "Профиль успешно обновлен"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  def update_by_manager
    if @user.update_attributes(visible_for_bux: params[:user][:visible_for_bux])
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
      if !manager?(current_user)
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
end
