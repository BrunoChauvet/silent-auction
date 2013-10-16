require 'spec_helper'

describe UsersController do
  it "assigns the users for selected user_group" do
    group1 = UserGroup.create(name: 'Group 1')
    group2 = UserGroup.create(name: 'Group 2')

    jsmith = User.create(user_group: group1, title: 'Mr', first_name: 'John', last_name: 'Smith')
    lmoore = User.create(user_group: group1, title: 'Mrs', first_name: 'Lisa', last_name: 'Moore')
    plang = User.create(user_group: group2, title: 'Mr', first_name: 'Pat', last_name: 'Lang')

    get :index, table_id: group1.id

    assigns(:users).should include(jsmith, lmoore)
  end
end
