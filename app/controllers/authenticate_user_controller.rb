class AuthenticateUserController < ApplicationController
	def tables
    @tables = UserGroup.find(:all, order: :name)
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
        redirect_to new_bid_path
      else
        flash.keep
        redirect_to new_user_session_path(User.find(params[:id])), :flash => { :error => "Invalid Pin" }
      end
    end
  end
end
