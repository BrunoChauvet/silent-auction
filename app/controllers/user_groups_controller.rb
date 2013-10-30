class UserGroupsController < ApplicationController
	def index
    @user_groups = UserGroup.find(:all, order: :sort_order)
  end
end
