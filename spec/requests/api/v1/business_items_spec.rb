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
    @item_6 = create(:item, distributor: @distributor)
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
    binding.pry
    expect(result["data"][0]["attributes"]["id"]).to eq(@business_item_1.id)
    expect(result["data"][0]["attributes"]["price_sold"]).to eq(@business_item_1.price_sold)
    expect(result["data"][-1]["attributes"]["price_sold"]).to eq(@business_item_5.price_sold)
  end

  it 'sends back 404 if invalid api key with get' do
    get '/api/v1/businesses/account', params: {api_key: "invalid_api_key"}

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    result = JSON.parse(response.body)
    expect(result["error"]).to eq("Couldn't find Business")
  end

  it 'creates a new business item attached to an item' do
    post '/api/v1/business_items', params: {
                                            api_key: @business.api_key,
                                            price_sold: 22.5,
                                            quantity: nil,
                                            serving_size: 2,
                                            item_id: @item_6.id
                                           }
    expect(response).to be_successful
    expect(response.status).to eq(201)
    bi = BusinessItem.last
    expect(bi.business).to eq(@business)
    expect(bi.item).to eq(@item_6)
  end

  it 'sends back 404 if invalid api key with post' do
    post '/api/v1/business_items', params: {
                                            api_key: 'invalid',
                                            price_sold: 22.5,
                                            quantity: nil,
                                            serving_size: 2,
                                            item_id: @item_6.id
                                           }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    result = JSON.parse(response.body)
    expect(result["error"]).to eq("Couldn't find Business")
  end

  it 'sends back a 422 status if missing information when creating it' do
    post '/api/v1/business_items', params: {
                                            api_key: @business.api_key,
                                            quantity: nil,
                                            serving_size: 2,
                                            item_id: @item_6.id
                                           }

    expect(response).to_not be_successful
    message = JSON.parse(response.body)
    expect(message).to eq({"price_sold"=>["can't be blank", "is not a number"]})
    expect(response.status).to eq(422)
  end

  it 'updates a business item in the database' do

    price_sold = 34
    quantity = 4
    serving_size = 2

    patch "/api/v1/business_items/#{@business_item_1.id}", params: {
                                                                    api_key: @business.api_key,
                                                                    price_sold: price_sold,
                                                                    quantity: quantity,
                                                                    serving_size: serving_size
                                                                   }

    result = JSON.parse(response.body)['data']

    expect(response.status).to eq(200)
    expect(result['id']).to eq(@business_item_1.id.to_s)
    expect(result['attributes']['price_sold']).to eq(price_sold)
    expect(result['attributes']['quantity']).to eq(quantity)
    expect(result['attributes']['serving_size']).to eq(serving_size)

    bi = BusinessItem.find(@business_item_1.id)
    expect(bi.price_sold).to eq(price_sold)
    expect(bi.quantity).to eq(quantity)
    expect(bi.serving_size).to eq(serving_size)
  end

  it 'returns 404 if invalid api key' do

    price_sold = 34
    quantity = 4
    serving_size = 2

    patch "/api/v1/business_items/#{@business_item_1.id}", params: {
                                                                    api_key: 'invalid',
                                                                    price_sold: price_sold,
                                                                    quantity: quantity,
                                                                    serving_size: serving_size
                                                                   }

    result = JSON.parse(response.body)['data']

    expect(response.status).to eq(404)
    expect(JSON.parse(response.body)['error']).to eq("Couldn't find Business")
  end

  it 'returns 404 if invalid business item id' do

    price_sold = 34
    quantity = 4
    serving_size = 2

    patch "/api/v1/business_items/0", params: {
                                                                    api_key: @business.api_key,
                                                                    price_sold: price_sold,
                                                                    quantity: quantity,
                                                                    serving_size: serving_size
                                                                   }

    expect(response).to_not be_successful
    result = JSON.parse(response.body)
    expect(result).to eq({"error"=>"Couldn't find BusinessItem with 'id'=0"})
    expect(response.status).to eq(404)
  end


end
