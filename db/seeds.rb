require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
Coupon.destroy_all
User.destroy_all

admin = create(:admin)
user = create(:user)
merchant_1 = create(:merchant)

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

inactive_merchant_1 = create(:inactive_merchant)
inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
create_list(:item, 10, user: merchant_1)
inactive_item_1 = create(:inactive_item, user: merchant_1)
inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

coupon_1 = create(:coupon, user: merchant_2)
coupon_2 = create(:coupon, user: merchant_3)
coupon_3 = create(:percent_coupon, user: merchant_3)
coupon_4 = create(:percent_coupon, user: merchant_4)
create_list(:coupon, 5, user: merchant_1)
inactive_coupon_1 = create(:inactive_coupon, user: merchant_3)

Random.new_seed
rng = Random.new

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: (rng.rand(5)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# pending order
order = create(:order, user: user)
create(:order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user, created_at: (rng.rand(4)+1).months.ago)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+1).months.ago)
order_1 = create(:fulfilled_order_item, order: order_1, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+2).months.ago)
create(:fulfilled_order_item, order: order_1, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+2).months.ago)
order_2 = create(:fulfilled_order_item, order: order_2, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+3).months.ago)
create(:fulfilled_order_item, order: order_2, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+3).months.ago)
order_3 = create(:fulfilled_order_item, order: order_3, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+4).months.ago)
create(:fulfilled_order_item, order: order_3, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+4).months.ago)
order_4 = create(:fulfilled_order_item, order: order_4, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+5).months.ago)
create(:fulfilled_order_item, order: order_4, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+5).months.ago)
order_5 = create(:fulfilled_order_item, order: order_5, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+6).months.ago)
create(:fulfilled_order_item, order: order_5, item: item_1, price: 1, quantity: 1, created_at: (rng.rand(4)+6).months.ago)

puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
puts "Coupons created: #{Coupon.count.to_i}"
