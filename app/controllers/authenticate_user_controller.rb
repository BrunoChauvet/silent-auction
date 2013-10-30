class AuthenticateUserController < ApplicationController
	def tables
    @tables = UserGroup.find(:all, order: :sort_order)
  end

  def users
    @users = User.where('user_group_id = ?', params[:id])
  end

  def authenticate
    if request.get?
    	@user = User.find(params[:id])
    elsif request.post?
      @user = warden.authenticate!(params)
      if @user
        redirect_to bids_path
      else
        redirect_to new_user_session_path(User.find(params[:id]), {:param_1 => "Test message"})
      end
    end
  end
end
