### Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:00:00+0900')

### Data
ImportUsers.import 'public/gala_tables.xls'
ImportItems.import 'public/gala_content.xlsx'

# Staff
staff_table = UserGroup.create(name: "Staff", sort_order: UserGroup.maximum(:sort_order) + 1)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Bruno', last_name: 'Chauvet', pin: 1234, admin: true)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Alexis', last_name: 'Bouvot', pin: 1234, admin: true)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Denis', last_name: 'Gittar', pin: 1234, admin: true)
