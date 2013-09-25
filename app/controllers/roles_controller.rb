class RolesController < ApplicationController
  before_filter :check_if_admin
  
  def index
    @roles = Role.all
  end

end
