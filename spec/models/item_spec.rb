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
    before :each do
      @distributor_1 = Distributor.create!(name: "RNDC",
                                          address: "3319 Arapahoe st, Denver, CO",
                                          code: "CODE1234",
                                          api_key: "jgn983hy48thw9begh98h4539h4",
                                          password: "password"
                                          )
      @distributor_2 = Distributor.create!(name: "Other",
                                          address: "other",
                                          code: "other",
                                          api_key: "other",
                                          password: "other"
                                          )

      @rep = create(:representative, distributor: @distributor_1)
      @business = create(:business, distributor: @distributor_1, representative: @rep)
      @item_1 = create(:item, distributor: @distributor_1)
      @item_2 = create(:item, distributor: @distributor_1)
      @items = create_list(:item, 6, distributor: @distributor_1)

      @order = create(:order, business: @business)
      @order_2 = create(:order, business: @business)
      @order_item_1 = create(:order_item, order: @order_2, item: @item_1, quantity: 3)
      @order_item_2 = create(:order_item, order: @order_2, item: @item_2, quantity: 1)

      create(:order_item, order: @order, item: @items[3], quantity: 10)
      create(:order_item, order: @order, item: @items[1], quantity: 9)
      create(:order_item, order: @order, item: @items[0], quantity: 8)
      create(:order_item, order: @order, item: @items[2], quantity: 6)
      create(:order_item, order: @order, item: @items[5], quantity: 5)
      create(:order_item, order: @order, item: @items[4], quantity: 4)
      create(:item, distributor: @distributor_2)
    end
    it '.distributor_items' do

      items = Item.distributor_items(@distributor_1.id)

      expect(items.count).to eq(8)
      expect(items[0]).to be_an_instance_of(Item)
      expect(items[1]).to be_an_instance_of(Item)
      expect(items[0].id).to eq(@item_1.id)
      expect(items[1].id).to eq(@item_2.id)
      expect(items[0].distributor_id).to eq(@distributor_1.id)
      expect(items[1].distributor_id).to eq(@distributor_1.id)
    end

    it '.get_items' do
      items = [{id: @item_1.id, quantity: 4, price: 5.8}, {id: @item_2.id, quantity: 2, price: 20}]
      message = Item.get_items(items)
      expect(message).to eq("4 #{@item_1.name}s, 2 #{@item_2.name}s")
    end

    it '.item_popularity' do
      expect(Item.item_popularity(4, :desc)).to eq([@items[3], @items[1], @items[0], @items[2]])
      expect(Item.item_popularity(4, :asc)).to eq([@item_2, @item_1, @items[4], @items[5]])
    end

  end



end
