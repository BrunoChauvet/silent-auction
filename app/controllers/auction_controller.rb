class AuctionController < ApplicationController
  layout 'auction', only: [:index]
  
  def index
    respond_to do |format|
      format.html { }
      format.json {
        auction = []
        items = Item.order(:code)
        items.each do |item|
          last_bid = Bid.where(item: item).order('timestamp desc').first
          auction << {item: item, bid: last_bid, user: last_bid.try(:user)}
        end
        render json: auction
      }
    end
  end

  def amount_raised
    amount_raised = 0
    items = Item.all
    items.each do |item|
      last_bid = Bid.where(item: item).order('timestamp desc').first
      amount_raised = amount_raised + last_bid.price if last_bid
    end
    render json: {amount_raised: amount_raised}
  end

  def time_left
    time_left = ((Preference.end_time - DateTime.now) * 24 * 60 * 60).to_i
    render json: {time_left: time_left}
  end

end
