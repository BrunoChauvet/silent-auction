### Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:00:00+0900')

### Data

# Staff
staff_table = UserGroup.create(name: "Staff", sort_order: 0)
User.create(user_group: staff_table, title: 'Mr', first_name: 'Bruno', last_name: 'Chauvet', pin: 1234, admin: true)

# People
(1..30).each do |n|
  UserGroup.create(name: "Table #{n}", sort_order: n)
end
tables = UserGroup.all.where('sort_order > 0').order('sort_order')

jsmith = User.create(user_group: tables[0], title: 'Mr', first_name: 'John', last_name: 'Smith', pin: 1234)
lmoore = User.create(user_group: tables[0], title: 'Mrs', first_name: 'Lisa', last_name: 'Moore', pin: 1234)

User.create(user_group: tables[0], title: 'Mr', first_name: 'Corine', last_name: 'Helmer', pin: 1234)
User.create(user_group: tables[0], title: 'Mr', first_name: 'Emma', last_name: 'Lou', pin: 1234)
User.create(user_group: tables[0], title: 'Mr', first_name: 'Alejandra', last_name: 'Elwood', pin: 1234)
User.create(user_group: tables[0], title: 'Mr', first_name: 'Edward', last_name: 'Baumgardner', pin: 1234)
User.create(user_group: tables[0], title: 'Mr', first_name: 'Kristopher', last_name: 'Thornhill', pin: 1234)
User.create(user_group: tables[0], title: 'Mr', first_name: 'Sebastian', last_name: 'Ristow', pin: 1234)
User.create(user_group: tables[0], title: 'Mr', first_name: 'Vinnie', last_name: 'Blazier', pin: 1234)

User.create(user_group: tables[1], title: 'Mr', first_name: 'Sabina', last_name: 'Wahlstrom', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Linda', last_name: 'Embrey', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Vern', last_name: 'Facemire', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Mina', last_name: 'Boze', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Elizbeth', last_name: 'Griffieth', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Ashli', last_name: 'Maudlin', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Dyan', last_name: 'Beecham', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Kizzy', last_name: 'Valero', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Herminia', last_name: 'Jimenez', pin: 1234)
User.create(user_group: tables[1], title: 'Mr', first_name: 'Cathryn', last_name: 'Mullis', pin: 1234)

User.create(user_group: tables[2], title: 'Mr', first_name: 'Latasha', last_name: 'Sherwood', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Rosalyn', last_name: 'Barela', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Rene', last_name: 'Sally', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Michael', last_name: 'Baginski', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Leandro', last_name: 'Go', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Danika', last_name: 'Konrad', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Sean', last_name: 'Stclaire', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Sondra', last_name: 'Suiter', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Everett', last_name: 'Tonkin', pin: 1234)
User.create(user_group: tables[2], title: 'Mr', first_name: 'Caron', last_name: 'Nova', pin: 1234)

User.create(user_group: tables[3], title: 'Mr', first_name: 'Mildred', last_name: 'Montilla', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Glendora', last_name: 'Covey', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Teri', last_name: 'Toner', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Annika', last_name: 'Passmore', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Donnetta', last_name: 'Paolucci', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Dot', last_name: 'Uy', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Aleta', last_name: 'Blauvelt', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Iona', last_name: 'Oberlin', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Natisha', last_name: 'Doescher', pin: 1234)
User.create(user_group: tables[3], title: 'Mr', first_name: 'Mack', last_name: 'Madison', pin: 1234)

User.create(user_group: tables[4], title: 'Mr', first_name: 'Majorie', last_name: 'Nordberg', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Ali', last_name: 'Moody', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Al', last_name: 'Fogg', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Christin', last_name: 'Mckern', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Fernanda', last_name: 'Linnen', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Nana', last_name: 'Ratley', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Tamika', last_name: 'Weekley', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Percy', last_name: 'Chrzanowski', pin: 1234)
User.create(user_group: tables[4], title: 'Mr', first_name: 'Dacia', last_name: 'Barra', pin: 1234)

ImportItems.import 'public/gala_content.xls'
