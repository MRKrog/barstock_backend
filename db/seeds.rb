require 'csv'

distributor = Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                    name: 'RNDC',
                    api_key: 'f01zdxN0RGWufApdZQxwUg',
                    password: 'password',
                    code: 'RNDC1234'
                    )

rep = Representative.create!(name: 'Mackenzie Frey',
                       email: 'mackenziefrey1@gmail.com',
                       phone_number: 7204805263,
                       distributor: Distributor.first
                      )

business = Business.create!(distributor: Distributor.first,
                             representative: Representative.first,
                             name: 'The Basement',
                             address: '78295 US Highway 40 Winter Park, CO',
                             email: 'michaelryankrog@gmail.com',
                             phone_number: 6307154311,
                             password: 'password',
                             api_key: '0yWwUm5CZ8CGR8MhT7FL9w')

items = CSV.new(File.open('./db/items.csv'), headers: true, header_converters: :symbol).read
items.each do |line|
  line = line.to_h
  Item.create!(line)
end

bi = CSV.new(File.open('./db/business-items.csv'), headers: true, header_converters: :symbol).read
bi.each do |line|
  line = line.to_h
  BusinessItem.create!(line)
end

order_1 = Order.create!(business: business,
                        total_cost: 93.18,
                        created_at: "2018-09-21 00:52:33")
order_2 = Order.create!(business: business,
                        total_cost: 117.2,
                        created_at: "2018-1-15 00:52:33")
oi_1 = OrderItem.create!(order: order_1,
                         item_id: 2,
                         quantity: 1,
                         price: 16.99)
oi_2 = OrderItem.create!(order: order_1,
                         item_id: 19,
                         quantity: 1,
                         price: 7.87)
oi_2 = OrderItem.create!(order: order_1,
                         item_id: 19,
                         quantity: 1,
                         price: 7.87)
oi_3 = OrderItem.create!(order: order_1,
                         item_id: 22,
                         quantity: 1,
                         price: 7.29)
oi_4 = OrderItem.create!(order: order_1,
                         item_id: 24,
                         quantity: 1,
                         price: 21.25)
oi_5 = OrderItem.create!(order: order_1,
                         item_id: 25,
                         quantity: 1,
                         price: 21.0)
oi_6 = OrderItem.create!(order: order_2,
                         item_id: 47,
                         quantity: 4,
                         price: 29.3)

puts 'seed data finished'
puts "Business created: #{Business.count.to_i}"
puts "Distributor created: #{Distributor.count.to_i}"
puts "Representative created: #{Representative.count.to_i}"
puts "Order created: #{Order.count.to_i}"
puts "Item created: #{Item.count.to_i}"
puts "OrderItem created: #{OrderItem.count.to_i}"
puts "BusinessItem created: #{BusinessItem.count.to_i}"
