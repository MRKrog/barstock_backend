class Representative < ApplicationRecord
  belongs_to :distributor
  has_many :businesses

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :phone_number, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
end
