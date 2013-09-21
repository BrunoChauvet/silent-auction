class AuctionController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json {
        auction = []

        items = Item.find(:all, order: :id)
        items.each do |item|
          last_bid = Bid.where(item: item).order('timestamp desc').first
          auction << {item: item, bid: last_bid, user: last_bid.try(:user)}
        end

        render json: auction
      }
    end
  end
end
