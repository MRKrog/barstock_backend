class BusinessItem < ApplicationRecord
  belongs_to :business
  belongs_to :item

  validates :price_sold, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
  validates :serving_size, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
end
