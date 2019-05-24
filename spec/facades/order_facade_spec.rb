require 'rails_helper'

describe OrderFacade do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )

    @item_1 = create(:item, distributor: @distributor)
    @item_2 = create(:item, distributor: @distributor)
    @rep = create(:representative, distributor: @distributor)
    @business = create(:business, distributor: @distributor, representative: @rep)
    @order_1 = create(:order, business: @business)
    @order_2 = create(:order, business: @business)
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2)
    @order_item_3 = create(:order_item, order: @order_2, item: @item_2)
    @facade = OrderFacade.new
  end
  it 'exists' do
    expect(@facade).to be_a(OrderFacade)
  end

  describe "class methods" do
    it '.get_orders' do
      result = OrderFacade.get_orders(@business)
      expect(result.count).to eq(2)
      expect(result[0].id).to eq(@order_2.id)
      expect(result[1].id).to eq(@order_1.id)
      expect(result[1].items.count).to eq(2)
      expect(result[0].items.count).to eq(1)
    end
  end
end
