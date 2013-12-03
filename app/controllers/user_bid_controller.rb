class UserBidController < MobileApplicationController
  before_filter :authenticate_user!

  def all_items
    @items = Item.all.order('code ASC')
  end

  def current_bids
    respond_to do |format|
      format.html {}
      format.json {
        bids = []
        items = Item.all.order(:code).to_a
        items.each do |item|
          last_bid = Bid.where(item: item).order('timestamp desc').first
          min_price = last_bid.present? ? last_bid.price + item.bid_increment : item.start_price
          bids << {
                    item: item,
                    price: last_bid.present? ? last_bid.price : item.start_price,
                    min_price: min_price,
                    status: bid_status(item, last_bid)}
        end

        render json: bids
      }
    end
  end

  def place_bid
    begin
      item = Item.find(params[:item][:id])
      bid = Bid.place(item, current_user, params[:price].to_d, current_user)
      render json: {success: true, item: item, user: current_user, bid: bid}
    rescue Exception => e
      render json: {success: false, message: e.message, minimum_price: item.minimum_price, current_price: item.current_price}
    end
  end

private

  def bid_status(item, last_bid)
    item_bids_count = Bid.where(item: item).count
    if item_bids_count == 0
      return 'start-price'
    end
    
    if last_bid.user == current_user
      return 'owner'
    end

    user_item_bids_count = Bid.where(item: item, user: current_user).count
    if user_item_bids_count > 0
      return 'outbidded'
    end

    return 'none'
  end

end
