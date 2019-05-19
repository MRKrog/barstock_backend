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
    it { should have_many :orders }
    it { should have_many :business_items }
    it { should have_many(:order_items).through(:orders) }
  end
end
