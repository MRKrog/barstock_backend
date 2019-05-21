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

  def create_order_items(order_items_params, order_id)
    count = 0
    order_items_params.each do |item|
      OrderItem.create!(quantity: order_items_params[count][:quantity], price: order_items_params[count][:price], order_id: order_id, item_id: order_items_params[count][:id].to_i, unit: 1)
      count += 1
    end
  end
end
