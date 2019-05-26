class Order < ApplicationRecord
  belongs_to :business
  has_many :order_items
  has_many :items, through: :order_items

  validates :total_cost, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
  validates :total_revenue, presence: true, numericality: {
    only_integer: false
  }

  def create_order_items(items, order_id)
    items.each do |item|
      oi = OrderItem.create!(quantity: item[:quantity],
                             price: item[:price],
                             order_id: order_id,
                             item_id: item[:id])
    end
  end

  def message(business, items)
    data = {}
    data[:distributor] = business.distributor
    data[:items] = Item.get_items(items)
    data[:phone_number] = business.phone_number
    data[:name] = business.name
    data[:address] = business.address
    data[:email] = business.email
    data[:rep_email] = business.representative.email
    data
  end
end
