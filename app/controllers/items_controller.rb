class ItemsController < ApplicationController
	def index
    @items = Item.find(:all, order: :id)
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
    item = Item.find(params[:id])
    bid = Bid.where(item: item).order('timestamp desc').first
    if item.start_price > params[:price]
      render json: {success: false, message: 'Price cannot be lower than start price', price: item.start_price}
    elsif bid.present? && bid.price >= params[:price]
      render json: {success: false, message: 'Asked price is to low', price: bid.price}
    else
      user = User.find(params[:user_id])
      bid = Bid.create!(user: user, item: item, price: params[:price], timestamp: Time.now)
      render json: {success: true, item: item, user: user, bid: bid}
    end
  end
end
