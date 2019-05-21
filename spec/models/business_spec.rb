require 'rails_helper'

RSpec.describe Business, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_numericality_of(:phone_number).only_integer }
    it { should validate_numericality_of(:phone_number).is_greater_than_or_equal_to(1) }
    it { should validate_presence_of :password }
    it { should validate_presence_of :api_key }
    it { should validate_uniqueness_of :api_key }

  end

  describe 'relationships' do
    it { should belong_to :distributor }
    it { should belong_to :representative }
    it { should have_many :orders }
    it { should have_many :business_items }
    it { should have_many(:order_items).through(:orders) }
  end

  describe 'class methods' do
    it '.create_new' do
      params = {
                name: "Cool Bar",
                address: "1 st",
                email: "whatever@example.com",
                password: "password",
                phone_number: "1234" 
               }
      code = "CODE1234"
      business = Business.create_new(params, code)
      expect(business).to be_a(Business)
      expect(business.name).to eq(params["name"])
      expect(business.address).to eq(params["address"])
      expect(business.email).to eq(params["email"])
      expect(business.phone_number.to_s).to eq(params["phone_number"])
    end

    it '.get_key' do
      key = Business.get_key
      expect(key).to be_a(String)
      expect(key.length).to eq(22)
    end
  end
end
