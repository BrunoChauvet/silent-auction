require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :title => "Title",
        :first_name => "First Name",
        :last_name => "Last Name",
        :pin => "Pin",
        :user_group => "User Group"
      ),
      stub_model(User,
        :title => "Title",
        :first_name => "First Name",
        :last_name => "Last Name",
        :pin => "Pin",
        :user_group => "User Group"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Pin".to_s, :count => 2
    assert_select "tr>td", :text => "User Group".to_s, :count => 2
  end
end
