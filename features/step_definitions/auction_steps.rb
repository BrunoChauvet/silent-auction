Given(/^the following items exist$/) do |table|
  table.hashes.each do |row|
  	FactoryGirl.create(:item, code: row['Code'])
  end
end

When(/^I go to the auction page$/) do
  visit '/auction'
end

Then(/^I should see the following items on the auction screen$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
