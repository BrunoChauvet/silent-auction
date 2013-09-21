class UsersController < ApplicationController
  def index
    @users = User.where('user_group_id = ?', params['user_group_id'])
  end
end
