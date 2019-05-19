class Distributor < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :representatives
  has_many :businesses

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :code
  validates_uniqueness_of :code
  validates_presence_of :api_key
  validates_uniqueness_of :api_key
  validates_presence_of :password

end
