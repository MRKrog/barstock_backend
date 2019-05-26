require 'rails_helper'

describe 'Orders Statistics API', :type => :request do
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

  it 'sends back the most popular items and the least popular items' do

    body = {
            "api_key": @business.api_key,
            "order": "desc",
            "limit": "4"
            }

    get '/api/v1/businesses/items_popularity', params: body
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq(body[:limit].to_i)
    expect(result[0]["attributes"]["name"]).to eq(@items[3].name)
    expect(result[1]["attributes"]["name"]).to eq(@items[1].name)
    expect(result[2]["attributes"]["name"]).to eq(@items[0].name)
    expect(result[3]["attributes"]["name"]).to eq(@items[2].name)

    body = {
            "api_key": @business.api_key,
            "order": "asc",
            "limit": "3"
            }

    get '/api/v1/businesses/items_popularity', params: body
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq(body[:limit].to_i)
    expect(result[0]["attributes"]["name"]).to eq(@item_2.name)
    expect(result[1]["attributes"]["name"]).to eq(@item_1.name)
    expect(result[2]["attributes"]["name"]).to eq(@items[4].name)
  end
end
