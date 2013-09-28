class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery

  private
    
    def render_403
      render file: "public/403.html", status: 403
    end 

    def check_if_admin
      render_403 unless admin?(current_user)
    end

    def check_if_role
      render_403 if current_user.role.nil?
    end
end
