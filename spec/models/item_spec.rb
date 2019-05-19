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

  describe 'class methods' do
    it '#distributor_items' do
      distributor_id = 1
      items = Item.distributor_items(distributor_id)

      expect(items.count).to eq(2)
      expect(items[0]).to have_key('id')
      expect(items[0]).to have_key('name')
      expect(items[0]).to have_key('alc_type')
      expect(items[0]).to have_key('alc_category')
      expect(items[0]).to have_key('price')
      expect(items[0]).to have_key('ounces')
      expect(items[0]).to have_key('unit')
      expect(items[0]).to have_key('thumbnail')
      expect(items[0]).to have_key('quantity')
      expect(items[0]['distributor_id']).to eq(distributor_id)
    end
  end
end
