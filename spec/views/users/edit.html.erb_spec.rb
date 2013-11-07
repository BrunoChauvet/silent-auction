require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :title => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :pin => "MyString",
      :user_group => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_title[name=?]", "user[title]"
      assert_select "input#user_first_name[name=?]", "user[first_name]"
      assert_select "input#user_last_name[name=?]", "user[last_name]"
      assert_select "input#user_pin[name=?]", "user[pin]"
      assert_select "input#user_user_group[name=?]", "user[user_group]"
    end
  end
end
