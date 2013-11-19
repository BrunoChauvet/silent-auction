class AuthenticationController < MobileApplicationController
  
  def tables
    @tables = UserGroup.find(:all, order: :sort_order)
  end

  def users
    @users = User.where('user_group_id = ?', params[:id]).order('last_name, first_name')
  end

  def user_pin
    if request.get?
      @user = User.find(params[:id])
    elsif request.post?
      @user = warden.authenticate(params)
      if @user
        if @user.admin?
          redirect_to select_table_path
        else
          redirect_to current_bids_path
        end
      else
        flash[:error] = "Invalid pin"
        redirect_to user_pin_path(User.find(params[:id]))
      end
    end
  end

end
