class AuctionController < ApplicationController

  def index
    respond_to do |format|
      format.html {
        redirect_to user_groups_path if browser.ipad?
        redirect_to select_table_path if browser.mobile?
      }
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

  def time_left
    end_time_preference = Preference.where(name: 'END_TIME').first
    end_time = DateTime.strptime(end_time_preference.value, '%Y-%m-%d %H:%M:%S')
    time_left = ((end_time - DateTime.now) * 24 * 60 * 60).to_i
    render json: {time_left: time_left}
  end

end
