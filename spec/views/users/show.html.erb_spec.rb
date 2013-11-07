require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :title => "Title",
      :first_name => "First Name",
      :last_name => "Last Name",
      :pin => "Pin",
      :user_group => "User Group"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Pin/)
    rendered.should match(/User Group/)
  end
end
