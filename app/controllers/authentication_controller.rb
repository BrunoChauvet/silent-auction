class AuthenticationController < MobileApplicationController
  
  def tables
    if current_user.present?
      redirect_user(current_user)
      return
    end

    @tables = UserGroup.find(:all, order: :sort_order)
  end

  def users
    if current_user.present?
      redirect_user(current_user)
      return
    end

    @users = User.where('user_group_id = ?', params[:id]).order('last_name, first_name')
  end

  def user_pin
    if current_user.present?
      redirect_user(current_user)
      return
    end

    if request.get?
      @user = User.find(params[:id])
    elsif request.post?
      @user = warden.authenticate(params)
      if @user
        redirect_user(@user)
      else
        flash[:error] = "Invalid pin"
        redirect_to user_pin_path(User.find(params[:id]))
      end
    end
  end

private

  def redirect_user(user)
    if user.admin? 
      if browser.tablet?
        redirect_to select_table_path
      elsif browser.mobile?
        redirect_to current_bids_path
      else
        redirect_to admin_path
      end
    else
      redirect_to current_bids_path
    end
  end

end
