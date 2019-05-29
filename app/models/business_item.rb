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

  def self.get_item(bi)
    BusinessItemInfo.new(bi, bi.item)
  end

  def self.does_not_exist?(item_id)
    BusinessItem.find_by(item_id: item_id).nil?
  end

  def self.create_new(params, business)
    if BusinessItem.does_not_exist?(params[:item_id])
      BusinessItem.new(business: business,
                       item: Item.find(params[:item_id]),
                       price_sold: params[:price_sold],
                       quantity: params[:quantity],
                       serving_size: params[:serving_size]
                      )
    end
  end
end
