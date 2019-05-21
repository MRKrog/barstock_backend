class Business < ApplicationRecord
  has_secure_password

  belongs_to :distributor
  belongs_to :representative
  has_many :orders
  has_many :order_items, through: :orders
  has_many :business_items

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :api_key
  validates_uniqueness_of :api_key
  validates_presence_of :password
  validates :phone_number, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  def self.create_new(b_params, code_rep_params)
    business = Business.new(b_params)
    business.api_key = self.get_key
    business.distributor = Distributor.find_by(code: code_rep_params["distributor_code"])
    business.representative = Representative.find_by(name: code_rep_params["rep"])
    return business
  end

  def self.get_key
    SecureRandom.urlsafe_base64
  end

end
