u = User.create(email:'abc@email.com', name:'Max Mustermann')

c1 = Collection.create(name:'Fridge', user: u)
i1 = Item.create(name:'Water-still', collection: c1, price:'0.50')
i2 = Item.create(name:'Water-bubbly',collection: c1, price:'0.50')
i3 = Item.create(name:'Lemonade',collection: c1, price: 1.00)

c2 = Collection.create(name:'Snackbox', user: u)
i4 = Item.create(name:'Mars', collection: c2, price:'0.80')
i5 = Item.create(name:'Snickers',collection: c1, price:0.50)
