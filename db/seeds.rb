require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

Item.destroy_all
Distributor.destroy_all
Representative.destroy_all
Business.destroy_all
BusinessItem.destroy_all
Order.destroy_all
OrderItem.destroy_all

distributor = Distributor.create!(name: 'RNDC',
                                  address: '3319 Arapahoe st, Denver, CO',
                                  code: 'CODE1234',
                                  api_key: 'jgn983hy48thw9begh98h4539h4',
                                  password: 'password'
                                  )

business = create(:business, api_key: '444444444', distributor: distributor)
representative = create(:representative, distributor: distributor)

item_1 = create(:item, distributor: distributor)
item_2 = create(:item, distributor: distributor)
item_3 = create(:item, distributor: distributor)
item_4 = create(:item, distributor: distributor)
create_list(:item, 20, distributor: distributor)

business_item_1 = create(:business_item, business: business, item: item_1)
business_item_2 = create(:business_item, business: business, item: item_2)
business_item_3 = create(:business_item, business: business, item: item_3)
business_item_4 = create(:business_item, business: business, item: item_4)

order = create(:order, business: business)

rng = Random.new

create(:order_item, order: order, item: item_1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_2, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_3, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_3, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_4, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

puts 'seed data finished'
puts "Business created: #{Business.count.to_i}"
puts "Distributor created: #{Distributor.count.to_i}"
puts "Representative created: #{Representative.count.to_i}"
puts "Order created: #{Order.count.to_i}"
puts "Item created: #{Item.count.to_i}"
puts "OrderItem created: #{OrderItem.count.to_i}"
puts "BusinessItem created: #{BusinessItem.count.to_i}"
