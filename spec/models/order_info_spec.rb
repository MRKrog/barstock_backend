require 'rails_helper'

describe OrderInfo do
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
    @order = create(:order, business: @business)
    @order_item_1 = create(:order_item, order: @order, item: @item_1)
    @order_item_2 = create(:order_item, order: @order, item: @item_2)
    @order_info = OrderInfo.new(@order)
  end

  it 'exists' do
    expect(@order_info).to be_a(OrderInfo)
  end

  it 'has attributes' do
    expect(@order_info.id).to eq(@order.id)
    expect(@order_info.items.count).to eq(2)
    expect(@order_info.items[0]).to eq(@item_1)
    expect(@order_info.total_cost).to eq(@order.total_cost)
    expect(@order_info.total_revenue).to eq(@order.total_revenue)
  end

end
