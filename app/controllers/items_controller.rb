class ItemsController < ApplicationController
	def index
    @items = Item.find(:all, order: :id)
    @user = User.find(params[:user_id])
  end

  def show
    respond_to do |format|
      format.html {
        @item = Item.find(params[:id])
        @user = User.find(params[:user_id])
      }
      format.json {
        item = Item.find(params[:id])
        user = User.find(params[:user_id])
        bid = Bid.where(item: item).order('timestamp desc').first
        render json: {item: item, user: user, bid: bid}
      }
    end
  end

  def place_bid
    begin
      item = Item.find(params[:id])
      user = User.find(params[:user_id])
      bid = Bid.place(item, user, params[:price])
      flash[:message] = "Bid has been placed"
      render json: {success: true, item: item, user: current_user, bid: bid}
    rescue Exception => e
      render json: {success: false, message: e.message, price: params[:price]}
    end
  end
end
