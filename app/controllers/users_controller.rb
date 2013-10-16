class UsersController < ApplicationController
  def index
    @users = User.where('user_group_id = ?', params['table_id'])
  end
end
