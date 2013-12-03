When(/^I go to the auction page$/) do
  visit '/auction'
end

Given(/^the auction ends in (\d+) hours?$/) do |hours|
  end_time = Preference.where(name: 'END_TIME').first_or_create
  value = (Time.now + hours.to_i.hours).strftime "%Y-%m-%d %H:%M:%S%z" 
  end_time.update_attributes!(value: value)
end

Given(/^the auction has ended$/) do
  end_time = Preference.where(name: 'END_TIME').first_or_create
  value = (Time.now - 1.seconds).strftime "%Y-%m-%d %H:%M:%S%z" 
  end_time.update_attributes!(value: value)
end


Then(/^I should see the following items on the auction screen$/) do |table|
  eventually {
    page.should have_css('.item-container', :count => table.hashes.length)
    
    items = page.all(".item-container")
    actual_items = []
    items.each do |item|
      item.allow_reload!
      actual_items << {
        'Code' => item.find('.item-code').text,
        'Name' => item.find('.item-name').text,
        'Price' => item.find('.item-price').text,
        'Current bidder' => item.find('.item-user').text
      }
    end
    table.dup.diff!(actual_items)
  }
end
