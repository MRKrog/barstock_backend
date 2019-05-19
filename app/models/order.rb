class Order < ApplicationRecord
  belongs_to :business
  has_many :order_items
  has_many :items, through: :order_items

  validates :total_cost, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
end
