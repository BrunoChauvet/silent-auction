# Configuration
Preference.create(name: 'END_TIME', value: '2013-11-30 22:00:00')

# Data
table1 = UserGroup.create(name: 'Table 1')
table2 = UserGroup.create(name: 'Table 2')
table3 = UserGroup.create(name: 'Table 3')

jsmith = User.create(user_group: table1, title: 'Mr', first_name: 'John', last_name: 'Smith', pin: 1234)
lmoore = User.create(user_group: table1, title: 'Mrs', first_name: 'Lisa', last_name: 'Moore', pin: 1234)

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
