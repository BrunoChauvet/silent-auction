class HostBidController < MobileApplicationController
  before_filter :authenticate_user!, :authenticate_admin!

  def select_table
    @user_groups = UserGroup.all.order(:sort_order).to_a
  end

  def select_user
    @users = User.where('user_group_id = ?', params['table_id']).order('last_name, first_name')
  end

  def select_item
    @items = Item.all.order(:code).to_a
    @user = User.find(params[:user_id])
  end

  def select_amount
    @item = Item.find(params[:item_id])
    @user = User.find(params[:user_id])
  end

  def place_bid
    begin
      item = Item.find(params[:item_id])
      user = User.find(params[:user_id])
      bid = Bid.place(item, user, params[:price].to_d, current_user)
      flash[:message] = "Bid has been placed at $#{params[:price]}"
      render json: {success: true, item: item, user: current_user, bid: bid}
    rescue Exception => e
      render json: {success: false, message: e.message, minimum_price: item.minimum_price, current_price: item.current_price}
    end
  end

end
