u1 = User.create(email:'abc@email.com', name:'Max Mustermann')
u2 = User.create(email:'def@email.com', name:'Tom Mustermann')

c1 = Collection.create(name:'Fridge', user: u1, public: true)
i1 = Item.create(name:'Water-still', collection: c1, price:'0.50')
i2 = Item.create(name:'Water-bubbly',collection: c1, price:'0.50')
i3 = Item.create(name:'Lemonade',collection: c1, price: 1.00)

c2 = Collection.create(name:'Snackbox', user: u1, public: true)
i4 = Item.create(name:'Mars', collection: c2, price:'0.80')
i5 = Item.create(name:'Snickers',collection: c2, price:0.50, amount: 10)

t1 = Transaction.create(amount: 2, user: u2, item: i4)
t2 = Transaction.create(amount: 3, user: u2, item: i5)
t3 = Transaction.create(amount: 1, user: u2, item: i3)
t4 = Transaction.create(amount: 10, user: u2, item: i3)
