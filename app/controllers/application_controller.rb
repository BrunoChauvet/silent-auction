class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    if browser.ipad?
      redirect_to select_table_path 
    elsif browser.mobile?
      redirect_to list_items_path
    else
      redirect_to auction_path
    end
  end

end
