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

Then(/^I should see the error message "(.*?)"$/) do |message|
  find('#error').text.should eql(message)
end


def click_item(selector, item_name)
  item = nil
  table_rows = all(selector)
  table_rows.each do |table_row|
    if table_row.text == item_name
      item = table_row
    end
  end
  rase "#{item_name} not found" unless item
  item.find("a").click
end