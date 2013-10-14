class AuctionController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json {
        auction = []
        items = Item.all(order: :id)
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
    items = Item.all(order: :id)
    items.each do |item|
      last_bid = Bid.where(item: item).order('timestamp desc').first
      amount_raised = amount_raised + last_bid.price if last_bid
    end
    render json: {amount_raised: amount_raised}
  end

end
