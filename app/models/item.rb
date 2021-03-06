class Item < ApplicationRecord

  belongs_to :distributor
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :business_items
  has_many :business, through: :business_items


  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :alc_type
  validates_presence_of :alc_category
  validates :price, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
  validates :ounces, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
  validates_presence_of :unit
  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  def self.distributor_items(distributor_id)
    Item.where(distributor_id: distributor_id)
  end

  def self.get_items(items)
    message = items.map do |item|
      i = Item.find(item[:id])
      ActionController::Base.helpers.pluralize(item[:quantity], i.name)
    end
    message.join(", ")
  end

  def self.get_items_for_emails(items)
    items.map do |item|
      i = Item.find(item[:id])
      {id: i.id, name: i.name, quantity: item[:quantity], price: item[:price]}
    end
  end
  
  def self.item_popularity(limit = 3, order)
    Item.joins(:order_items)
      .select('items.*, sum(order_items.quantity) as total_ordered')
      .group(:id)
      .order("total_ordered #{order}")
      .limit(limit)
  end
end
