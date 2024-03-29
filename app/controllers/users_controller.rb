# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_if_admin,  only: :destroy
  before_filter :check_roles_groups, only: :update
  before_filter :check_if_admin_or_manager, only: [:edit, :update]
  before_filter :find_user, only: [:edit, :update, :destroy]

  def index
    if manager?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['manager_id = ? OR id = ?', current_user.id, current_user.id]).includes([:role, :group])
    elsif worker?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['id = ?', current_user.id]).includes([:role, :group])
    elsif bux?(current_user)
      @users = User.paginate(page: params[:page], conditions: ['visible_for_bux = ? OR id = ?', true, current_user.id]).includes([:role, :group])
    elsif admin?(current_user)
      @users = User.paginate(page: params[:page]).includes([:role, :group])
    else
      render_403
    end
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
    if admin?(current_user)
      render 'users/edit'
    else
      render 'users/edit_by_manager'
    end
  end

  def update
    if manager?(current_user)
      @user.update_attributes(visible_for_bux: params[:user][:visible_for_bux])
    else
      @user.update_attributes(params[:user])
    end  
    if @user.errors.empty?
      flash[:success] = "Профиль успешно обновлен"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
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
          find_user
          render 'edit'
        end
        if (group_t.builtin == 2) && (role_t.builtin == 2)
          flash[:error] = "#{role_t.name} не может иметь доступ в группу #{group_t.name}."
          find_user
          render 'edit'
        end
      end
    end
    
    def find_user
      @user = User.where(id: params[:id]).first
      render_404 unless @user
    end
end
