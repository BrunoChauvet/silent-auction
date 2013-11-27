### Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:30:00+1100')

### Data
ImportUsers.import 'public/gala_tables.xlsx'
puts "Imported #{User.count()} users"
ImportItems.import 'public/gala_content.xlsx'
puts "Imported #{Item.count()} items"

# Staff
staff_table = UserGroup.create(name: "Staff", sort_order: UserGroup.maximum(:sort_order) + 1)
User.create(user_group: staff_table, title: '', first_name: 'iPad', last_name: '', pin: 1515, admin: true)
