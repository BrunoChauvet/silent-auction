When(/^I go to the authentication page$/) do
  visit '/authenticate'
end

When(/^I select the table "(.*?)"$/) do |table_name|
  eventually { click_item('#tables .list-item', table_name) }
end

When(/^I select the user "(.*?)"$/) do |user_name|
  eventually { click_item('#users .list-item', user_name) }
end

When(/^I enter the pin "(.*?)"$/) do |pin|
  fill_in('pin', :with => pin)
  click_button('validate')
end

Given(/^I am authenticated$/) do
  steps %Q{
    Given the following users exist
      | Title | First name     | Last name   | Table   | Pin  |
      | Mr    | John           | Smith       | Table 1 | 1234 |
  }
  step %{I go to the authentication page}
  step %{I select the table "Table 1"}
  step %{I select the user "Mr John Smith"}
  step %{I enter the pin "1234"}
end

Given(/^I am authenticated as an admin$/) do
  steps %Q{
    Given the following users exist
      | Title | First name     | Last name   | Table   | Pin  | Admin |
      | Mr    | John           | Smith       | Table 1 | 1234 | true  |
  }
  step %{I go to the authentication page}
  step %{I select the table "Table 1"}
  step %{I select the user "Mr John Smith"}
  step %{I enter the pin "1234"}
end

def click_item(selector, item_name)
  item = nil
  table_rows = all(selector)
  table_rows.each do |table_row|
    if table_row.text == item_name
      item = table_row
    end
  end
  raise "#{item_name} not found" unless item
  item.find("a").click
end