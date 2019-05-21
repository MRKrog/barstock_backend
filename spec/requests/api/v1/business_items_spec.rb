require 'rails_helper'

describe 'Business Items API' do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
    @rep = create(:representative, distributor: @distributor)
    @business = create(:business, distributor: @distributor, representative: @rep)
    @item_1 = create(:item, distributor: @distributor)
    @item_2 = create(:item, distributor: @distributor)
    @item_3 = create(:item, distributor: @distributor)
    @item_4 = create(:item, distributor: @distributor)
    @item_5 = create(:item, distributor: @distributor)
    @business_item_1 = create(:business_item, business: @business, item: @item_1)
    @business_item_2 = create(:business_item, business: @business, item: @item_2)
    @business_item_3 = create(:business_item, business: @business, item: @item_3)
    @business_item_4 = create(:business_item, business: @business, item: @item_4)
    @business_item_5 = create(:business_item, business: @business, item: @item_5)
  end

  it 'sends a list of business items' do
    get '/api/v1/business_items', params: {api_key: @business.api_key}
    expect(response).to be_successful
    expect(response.status).to eq(200)
    result = JSON.parse(response.body)
    expect(result["data"][0]["attributes"]["id"]).to eq(@business_item_1.id)
    expect(result["data"][0]["attributes"]["price_sold"]).to eq(@business_item_1.price_sold)
    expect(result["data"][-1]["attributes"]["price_sold"]).to eq(@business_item_5.price_sold)
  end

  it 'sends back 404 if invalid api key' do
    get '/api/v1/businesses/account', params: {api_key: "invalid_api_key"}

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    result = JSON.parse(response.body)
    expect(result["error"]).to eq("Couldn't find Business")
  end
end
