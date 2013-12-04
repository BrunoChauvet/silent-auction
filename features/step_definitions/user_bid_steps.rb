Then(/^I should see my bids page$/) do
  find("#user-bid")
end

When(/^I select the item "(.*?)"$/) do |item_name|
  eventually {
  	bid_items = all('#user-bid .bid-item')
    found = false
	  bid_items.each do |bid_item|
      if item_name.include?(bid_item.find('.item-code').text) && item_name.include?(bid_item.find('.item-name').text)
        bid_item.find('a.user-bid-link').click
        found = true
        break
      end
	  end
    raise "#{item_name} not found" unless found
  }
end

Then(/^I should see a bid price of "(.*?)"$/) do |price|
  find('.current-price').text.should eql(price)
end

When(/^I submit the bid$/) do
  click_button('submit-bid')
end

When(/^I cancel my bid$/) do
  click_button('cancel-bid')
end

Then(/^I should see the following bids$/) do |table|
  eventually {
    actual_bids = []
    bid_items = all('#user-bid .bid-item')
    bid_items.each do |bid_item|
      actual_bids << {
        'Item' => "#{bid_item.find('.item-code').text} #{bid_item.find('.item-name').text}",
        'Price' => bid_item.find('.item-price').text
      }
    end

    table.dup.diff!(actual_bids)
  }
end

Given(/^the following bids exist$/) do |table|
  table.hashes.each do |row|
    user_bits = row['User'].split
    user = User.where(title: user_bits[0], first_name: user_bits[1], last_name: user_bits[2]).first
    raise "#{row['User']} not found" unless user
    item = Item.where(code: row['Item']).first
    raise "#{row['Item']} not found" unless item
    Bid.create!(user: user, item: item, price: row['Price'], timestamp: Time.now, placed_by: user)
  end
end
