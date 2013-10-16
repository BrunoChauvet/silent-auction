class BidsController < ApplicationController
  before_filter :authenticate_user!

  def index
  	respond_to do |format|
      format.html {}
      format.json {
        bids = []
        items = Item.all(order: :code)
        items.each do |item|
          last_bid = Bid.where(item: item).order('timestamp desc').first
          bids << {item: item, price: last_bid.present? ? last_bid.price : item.start_price, status: bid_status(item)}
        end

        render json: bids
      }
    end
  end

  def create
    item = Item.find(params[:item][:id])
    bid = Bid.where(item: item).order('timestamp desc').first
    if item.start_price > params[:price]
      render json: {success: false, message: 'Price cannot be lower than start price', price: item.start_price}
    elsif bid.present? && bid.price >= params[:price]
      render json: {success: false, message: 'Asked price is to low', price: bid.price}
    else
      bid = Bid.create!(user: current_user, item: item, price: params[:price], timestamp: Time.now)
      render json: {success: true, item: item, user: current_user, bid: bid}
    end
  end

private

  def bid_status(item)
    bids = Bid.where(item: item).order('timestamp desc')
    if bids.empty?
      return 'start-price'
    else
      if bids.first.user == current_user
        return 'owner'
      else
        bids[1..-1].each do |bid|
          if bid.user == current_user
            return 'outbidded'
          end
        end
        return 'none'
      end
    end
  end
end
