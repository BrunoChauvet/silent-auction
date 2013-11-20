Given(/^the following items exist$/) do |table|
  table.hashes.each do |row|
  	FactoryGirl.create(:item,
                        code: row['Code'],
                        name: row['Name'],
                        start_price: row['Start price'])
  end
end

When(/^I go to the auction page$/) do
  visit '/auction'
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
