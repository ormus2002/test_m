class AdminController < ApplicationController
  before_filter :check_if_admin 

  def index
  end

end
