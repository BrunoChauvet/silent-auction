class AuthenticateUserController < ApplicationController
	def tables
    @tables = UserGroup.find(:all, order: :name)
  end

  def users
    @users = User.where('user_group_id = ?', params[:id])
  end

  def authenticate
    user = User.find(params[:id])
  end
end
