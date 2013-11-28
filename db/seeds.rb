### Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:10:00+1100')

### Data
ImportUsers.import 'public/gala_tables.xlsx'
puts "Imported #{User.count()} users"
ImportItems.import 'public/gala_content.xlsx'
puts "Imported #{Item.count()} items"

# Staff
staff_table = UserGroup.create(name: "Staff", sort_order: UserGroup.maximum(:sort_order) + 1)
User.create(user_group: staff_table, title: '', first_name: 'iPad', last_name: '', pin: 1515, admin: true)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Bruno', last_name: 'Chauvet', pin: 1234, admin: true)
User.create(user_group: staff_table, title: 'Mrs', first_name: 'Cecile', last_name: 'Reyes-Chauvet', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Alexis', last_name: 'Bouvot', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Nicolas', last_name: 'Teulier', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Denis', last_name: 'Gittard', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Claude', last_name: 'Annonier', pin: 1234)
User.create(user_group: staff_table, title: 'Mrs', first_name: 'Sophie', last_name: 'Jarre', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Jeremy', last_name: "O'Connor", pin: 1234)
User.create(user_group: staff_table, title: 'Mrs', first_name: 'Agathe', last_name: 'Calandreau', pin: 1234)
User.create(user_group: staff_table, title: 'Mrs', first_name: 'Alyzee', last_name: 'Wyart', pin: 1234)
User.create(user_group: staff_table, title: 'Mrs', first_name: 'Clemence', last_name: 'Lefranc', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Christophe', last_name: 'Blanchys', pin: 1234)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Nicolas', last_name: 'Chaudhari', pin: 1234)
User.create(user_group: staff_table, title: 'Mrs', first_name: 'Chantelle', last_name: 'Buultjens', pin: 1234)
