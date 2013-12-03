Then(/^I should see the error message "(.*?)"$/) do |message|
  find('#error').text.should eql(message)
end

Then(/^I should see the success message "(.*?)"$/) do |message|
  find('#success').text.should eql(message)
end