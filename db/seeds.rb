### Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:00:00+0900')

### Data

# Staff
staff_table = UserGroup.create(name: "Staff", sort_order: 0)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Bruno', last_name: 'Chauvet', pin: 1234, admin: true)

ImportUsers.import 'public/gala_tables.xls'

ImportItems.import 'public/gala_content.xls'
