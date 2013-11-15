class HostBidController < ApplicationController
  before_filter :authenticate_user!

  def select_table
    @user_groups = UserGroup.find(:all, order: :sort_order)
  end

  def select_user
    @users = User.where('user_group_id = ?', params['table_id'])
  end

  def select_item
    @items = Item.find(:all, order: :code)
    @user = User.find(params[:user_id])
  end

  def select_amount
    @item = Item.find(params[:item_id])
    @user = User.find(params[:user_id])
    @last_bid = Bid.where(item: @item).order('timestamp desc').first
  end

  def place_bid
    begin
      item = Item.find(params[:item_id])
      user = User.find(params[:user_id])
      bid = Bid.place(item, user, params[:price].to_d)
      flash[:message] = "Bid has been placed at $#{params[:price]}"
      render json: {success: true, item: item, user: current_user, bid: bid}
    rescue Exception => e
      render json: {success: false, message: e.message, price: params[:price]}
    end
  end

end
