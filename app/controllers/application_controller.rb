class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    if browser.ipad?
      redirect_to select_table_path 
    elsif browser.mobile?
      redirect_to current_bids_path
    else
      redirect_to auction_path
    end
  end

  def authenticate_admin!
    (current_user.nil?) ? redirect_to(authenticate_select_table_path) : (redirect_to(authenticate_select_table_path) unless current_user.admin?)
  end

end
