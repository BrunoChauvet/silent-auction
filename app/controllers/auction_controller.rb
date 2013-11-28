class AuctionController < ApplicationController
  layout 'auction', only: [:index, :results]
  
  def index
    respond_to do |format|
      format.html { }
      format.json {
        render json: auction_summary
      }
    end
  end

  def results
    @auction = auction_summary
    @amount_raised = calculate_amount_raised
  end

  def amount_raised
    render json: {amount_raised: calculate_amount_raised}
  end

  def time_left
    time_left = ((Preference.end_time - DateTime.now) * 24 * 60 * 60).to_i
    time_left = 0 if time_left < 0
    render json: {time_left: time_left}
  end

private

  def auction_summary
    auction = []
    items = Item.order(:code)
    items.each do |item|
      last_bid = Bid.where(item: item).order('timestamp desc').first
      auction << {item: item, bid: last_bid, user: last_bid.try(:user)}
    end
    auction
  end

  def calculate_amount_raised
    amount_raised = 0
    items = Item.all
    items.each do |item|
      last_bid = Bid.where(item: item).order('timestamp desc').first
      amount_raised = amount_raised + last_bid.price if last_bid
    end
    amount_raised
  end

end
