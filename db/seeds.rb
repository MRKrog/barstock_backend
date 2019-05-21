Item.destroy_all
Distributor.destroy_all
Representative.destroy_all
Business.destroy_all
BusinessItem.destroy_all
Order.destroy_all
OrderItem.destroy_all

puts 'seed data finished'
puts "Business created: #{Business.count.to_i}"
puts "Distributor created: #{Distributor.count.to_i}"
puts "Representative created: #{Representative.count.to_i}"
puts "Order created: #{Order.count.to_i}"
puts "Item created: #{Item.count.to_i}"
puts "OrderItem created: #{OrderItem.count.to_i}"
puts "BusinessItem created: #{BusinessItem.count.to_i}"
