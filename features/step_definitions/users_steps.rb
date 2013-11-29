Given(/^the following users exist$/) do |table|
  table.hashes.each do |row|
    user_table = FactoryGirl.create(:table, name: row['Table'])
  	FactoryGirl.create(:user,
                        title: row['Title'],
                        first_name: row['First name'],
                        last_name: row['Last name'],
                        pin: row['Pin'],
                        user_group: user_table)
  end
end
