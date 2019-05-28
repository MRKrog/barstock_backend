require 'csv'

Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                    name: 'RNDC',
                    api_key: 'f01zdxN0RGWufApdZQxwUg',
                    password: 'password',
                    code: 'RNDC1234'
                    )

Representative.create!(name: 'Paul',
                       email: 'mackenziefrey1@gmail.com',
                       phone_number: 7204805263,
                       distributor: Distributor.first
                      )

Business.create!(distributor: Distributor.first,
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

puts 'seed data finished'
puts "Business created: #{Business.count.to_i}"
puts "Distributor created: #{Distributor.count.to_i}"
puts "Representative created: #{Representative.count.to_i}"
puts "Order created: #{Order.count.to_i}"
puts "Item created: #{Item.count.to_i}"
puts "OrderItem created: #{OrderItem.count.to_i}"
puts "BusinessItem created: #{BusinessItem.count.to_i}"
