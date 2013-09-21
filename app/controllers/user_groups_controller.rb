class UserGroupsController < ApplicationController
	def index
    @user_groups = UserGroup.find(:all, order: :name)
  end
end
