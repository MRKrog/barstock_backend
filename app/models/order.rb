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
      OrderItem.create!(quantity: item[:quantity],
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
    data
  end

  def email(business, items, total_cost)
    data = {}
    data[:items] = Item.get_items_for_emails(items)
    data[:phone_number] = business.phone_number
    data[:name] = business.name
    data[:address] = business.address
    data[:email] = business.email
    data[:rep_email] = business.representative.email
    # data[:rep_email] = ENV['MACKENZIE_EMAIL_FOR_TESTING_THIS_SHOULD_BE_DELETED']
    data[:total_cost] = total_cost
    data
  end
end
