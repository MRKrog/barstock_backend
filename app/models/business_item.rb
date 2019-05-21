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

  def self.get_items(business)
    business.business_items.map do |bi|
      BusinessItemInfo.new(bi, bi.item)
    end
  end
end
