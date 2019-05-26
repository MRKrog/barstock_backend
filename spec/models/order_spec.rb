require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of :total_cost }
    it { should validate_numericality_of(:total_cost).is_greater_than_or_equal_to(0) }
  end

  describe 'relationships' do
    it { should belong_to :business }
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end

  describe 'instance methods' do
    before :each do
      @distributor = Distributor.create!(name: 'RNDC',
                                        address: '3319 Arapahoe st, Denver, CO',
                                        code: 'CODE1234',
                                        api_key: 'jgn983hy48thw9begh98h4539h4',
                                        password: 'password'
                                        )

      @rep = create(:representative, distributor: @distributor)
      @business = create(:business, distributor: @distributor, representative: @rep)
      @item = create(:item, distributor: @distributor)
      @item_2 = create(:item, distributor: @distributor)

      @order = create(:order, business: @business)
    end
    it '#create_order_items' do

      order_items_params = [{id: @item.id, quantity: 4, price: 25}]

      expect(OrderItem.count).to eq(0)
      @order.create_order_items(order_items_params, @order.id)

      expect(OrderItem.all.count).to eq(1)
      expect(OrderItem.all[0].order_id).to eq(@order.id)
      expect(OrderItem.all[0].item_id).to eq(@item.id)
      expect(OrderItem.all[0].quantity).to eq(4)
      expect(OrderItem.all[0].price).to eq(25.0)
    end

    it '#message' do
      items = [{id: @item.id, quantity: 4, price: 5.8},
              {id: @item_2.id, quantity: 2, price: 20}]
      data = @order.message(@business, items)
      expect(data.keys).to eq([:distributor, :items, :phone_number])
      expect(data[:distributor]).to eq(@distributor)
      expect(data[:items]).to eq("4 #{@item.name}s, 2 #{@item_2.name}s")
      expect(data[:phone_number]).to eq(@business.phone_number)
    end

    it '#email' do
      items = [{id: @item.id, quantity: 4, price: 5.8},
              {id: @item_2.id, quantity: 2, price: 20}]

      data = @order.email(@business, items, @order.total_cost)

      expect(data.keys).to eq([:items, :phone_number, :name, :address, :email, :rep_email, :total_cost])
      expect(data[:items]).to eq([{:id=>@item.id, :name=>@item.name, :price=>5.8, :quantity=>4}, {:id=>@item_2.id, :name=>@item_2.name, :price=>20, :quantity=>2}])
      expect(data[:phone_number]).to eq(@business.phone_number)
      expect(data[:name]).to eq(@business.name)
      expect(data[:address]).to eq(@business.address)
      expect(data[:email]).to eq(@business.email)
      expect(data[:rep_email]).to eq(@business.representative.email)
      expect(data[:total_cost]).to eq(@order.total_cost)
    end
  end
end
