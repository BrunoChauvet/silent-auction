Given(/^the following items exist$/) do |table|
  table.hashes.each do |row|
  	FactoryGirl.create(:item,
                        code: row['Code'],
                        name: row['Name'],
                        start_price: row['Start price'],
                        bid_increment: row['Increment'])
  end
end