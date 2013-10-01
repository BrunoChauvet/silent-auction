table1 = UserGroup.create(name: 'Table 1')
table2 = UserGroup.create(name: 'Table 2')
table3 = UserGroup.create(name: 'Table 3')

jsmith = User.create(user_group: table1, title: 'Mr', first_name: 'John', last_name: 'Smith')
lmoore = User.create(user_group: table1, title: 'Mrs', first_name: 'Lisa', last_name: 'Moore')

item1 = Item.create(name: 'Vespa 12CV', description: 'Brand new Vespa 12CV from our sponsors', start_price: 650)
item2 = Item.create(name: 'Coffee Machine', description: 'Breville coffee machine with 2 years waranty', start_price: 100)
item3 = Item.create(name: 'Tahiti Escape', description: 'Holiday all inclusive package to french polynesia', start_price: 500)
item4 = Item.create(name: 'Hunter Valley Escape', description: '2 days package in the Hunter Valley for 2 people', start_price: 150)
item5 = Item.create(name: '12 Bottles of Bordeaux', description: 'A package of 12 bottles of Grands Crus from Burgundy (France)', start_price: 50)
item6 = Item.create(name: 'MacBook Pro', description: '13" MacBook Pro with retina display', start_price: 450)

Bid.create(user: jsmith, item: item1, price: 3500, timestamp: Time.now)

Bid.create(user: jsmith, item: item2, price: 220, timestamp: Time.now)

Bid.create(user: lmoore, item: item3, price: 2800, timestamp: Time.now)

Bid.create(user: jsmith, item: item4, price: 170, timestamp: Time.now - 1.minute)
Bid.create(user: lmoore, item: item4, price: 180, timestamp: Time.now)

Bid.create(user: jsmith, item: item5, price: 70, timestamp: Time.now)
