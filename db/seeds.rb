# Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:00:00+0900')

# Data
(1..30).each do |n|
  UserGroup.create(name: "Table #{n}", sort_order: n)
end
tables = UserGroup.all.order('sort_order')


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

exp = Category.create(name: 'Experiences')
electronics = Category.create(name: 'Electronics')


item101 = Item.create(code: '101', name: "Valentine's Day", description: "Enjoy two 'A Reserve' tickets for Il Divo at Sydney Opera House on Valentine's Day", start_price: 700, category: exp)
item102 = Item.create(code: '102', name: "Blue Mountains Weekend", description: "2 nights at the Hideaway Retreat Center", start_price: 350, category: exp)
item103 = Item.create(code: '103', name: "Escape to the Hunter Valley", description: "Discover Eaglereach Wilderness Resort for 6 guests", start_price: 600, category: exp)
item104 = Item.create(code: '104', name: "Vanuatu Gateaway for two", description: "Feet in the Sand Beach Holiday for three nights", start_price: 700, category: exp)
item105 = Item.create(code: '105', name: "French Up your life", description: "Ever dreamed of learning French? Express yourself in French!", start_price: 350, category: exp)
item106 = Item.create(code: '106', name: "Makeover your image", description: "Give yourself and a friend a makeover with 'Etincelle by Emilie' for two 2 hours vouchers", start_price: 400, category: exp)
item107 = Item.create(code: '107', name: "The French Bistros", description: "A taste of France with La Brasserie, Sel et Poivre, Le Montparnasse, Bistro papillon and Le Bergerac", start_price: 450, category: exp)
item108 = Item.create(code: '108', name: "La Traviata on Sydney harbour", description: "Handa Opera on Sydney Harbour - La Traviata. Experiance on of the world's greatest Operas.", start_price: 350, category: exp)
item109 = Item.create(code: '109', name: "Weekend Escape to a life of Luxury", description: "Enjoy 2 nights accomodation in a deluxe room with breakfast for two at the Five Star Sofitel Sydney Wentworth", start_price: 650, category: exp)
item110 = Item.create(code: '110', name: "French Beauty Hamper", description: "Natural Beauty Products from l'Occitane an Provence with 2 beautiful leather Lancel purse and wallet.", start_price: 650, category: exp)

item201 = Item.create(code: '201', name: "iPad2 3G 32GB", description: "iPad2 3G 32GB wireless conenction", start_price: 450, category: electronics)
item202 = Item.create(code: '202', name: "Nikon D5000 Twin Kit", description: "Camera Nikon D5000 twin kit 18-55mm abd 55-200mm VR Lenses.", start_price: 600, category: electronics)
item203 = Item.create(code: '203', name: "Samsung LED 3D Smart TV 46'", description: "Samsung LED 3D Smart TV 46' Full HD", start_price: 600, category: electronics)
item204 = Item.create(code: '204', name: "Nokia N9", description: "Latest Nokia mobile phone", start_price: 400, category: electronics)
item205 = Item.create(code: '205', name: "Digital Wireless Speaker", description: "Digital Wireless Speaker indoor / outdoor", start_price: 150, category: electronics)


Bid.create(user: jsmith, item: item101, price: 750, timestamp: Time.now)
