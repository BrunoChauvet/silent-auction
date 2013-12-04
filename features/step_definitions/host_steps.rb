When(/^I select the item "(.*?)" to place a guest bid$/) do |item_name|
  eventually {
  	bid_items = all('#items .list-item')
    found = false
	  bid_items.each do |bid_item|
      if bid_item.text == item_name
        bid_item.find('a').click
        found = true
        break
      end
	  end
    raise "#{item_name} not found" unless found
  }
end