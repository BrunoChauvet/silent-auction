When(/^I go to the authentication page$/) do
  visit '/authenticate'
end

When(/^I select the table "(.*?)"$/) do |table_name|
  table_rows = all('#tables .list-item')
  table_rows.each do |table_row|
    if table_row.text == table_name
      table_row.click
    end
  end
end

When(/^I select the user "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I enter the pin "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see my bids page$/) do
  pending # express the regexp above with the code you wish you had
end