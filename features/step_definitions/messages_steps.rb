Then(/^I should see the error message "(.*?)"$/) do |message|
  find('#error').text.should include(message)
end

Then(/^I should see the success message "(.*?)"$/) do |message|
  find('#success').text.should include(message)
end