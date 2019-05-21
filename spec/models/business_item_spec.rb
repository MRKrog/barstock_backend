require 'rails_helper'

RSpec.describe BusinessItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :price_sold }
    it { should validate_numericality_of(:price_sold).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :serving_size }
    it { should validate_numericality_of(:serving_size).is_greater_than_or_equal_to(0) }
  end

  describe 'relationships' do
    it { should belong_to :business }
    it { should belong_to :item }
  end

  describe 'class methods' do
    before :each do
      @distributor = Distributor.create!(name: 'RNDC',
        address: '3319 Arapahoe st, Denver, CO',
        code: 'CODE1234',
        api_key: 'jgn983hy48thw9begh98h4539h4',
        password: 'password'
      )
      @rep = create(:representative, distributor: @distributor)
      @business = create(:business, distributor: @distributor, representative: @rep)
      @item_6 = create(:item, distributor: @distributor)
      @business_item_6 = create(:business_item, business: @business, item: @item_6)
    end

    it '.get_items' do
      items = BusinessItem.get_items(@business)
      expect(items).to be_a(Array)
      expect(items[0].price_sold).to eq(@business_item_6.price_sold)
      expect(items[0].alc_type).to eq(@item_6.alc_type)
    end

    it '.create_new' do
      params = {
                api_key: "k2RJ_UvdG4kH3QRtFJ_j5A",
                price_sold: "22.5",
                quantity: nil,
                serving_size: "2",
                item_id: @item_6.id
                }
      bi = BusinessItem.create_new(params, @business)
      bi.save!
      expect(bi).to be_a(BusinessItem)
      expect(bi.business).to be(@business)
      expect(bi.item).to eq(@item_6)
    end
  end
end
