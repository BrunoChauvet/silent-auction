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
        items = Item.all(order: :code)
        items.each do |item|
          last_bid = Bid.where(item: item).order('timestamp desc').first
          min_price = last_bid.present? ? last_bid.price + Bid::MINIMUM_INCREMENT : item.start_price
          bids << {
                    item: item,
                    price: last_bid.present? ? last_bid.price : item.start_price,
                    min_price: min_price,
                    status: bid_status(item)}
        end

        render json: bids
      }
    end
  end

  def place_bid
    begin
      item = Item.find(params[:item][:id])
      bid = Bid.place(item, current_user, params[:price].to_d)
      render json: {success: true, item: item, user: current_user, bid: bid}
    rescue Exception => e
      render json: {success: false, message: e.message, price: params[:price]}
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
