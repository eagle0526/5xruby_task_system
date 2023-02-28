class ApplicationController < ActionController::Base

  include ApplicationHelper
  
  def authenticate_user!
    if not user_signed_in?
      redirect_to login_users_path, alert: "請先登入"
    end
  end
end
