require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :alc_type }
    it { should validate_presence_of :alc_category }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :ounces }
    it { should validate_numericality_of(:ounces).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :unit }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end

  describe 'relationships' do
    it { should belong_to :distributor }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
    it { should have_many :business_items }
    it { should have_many(:business).through(:business_items) }
  end
end
