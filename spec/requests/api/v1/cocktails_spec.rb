require 'rails_helper'

describe 'Cocktails API' do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
    @rep = create(:representative, distributor: @distributor)
    @business = create(:business, distributor: @distributor, representative: @rep)
    @item_1 = create(:item, alc_category: "whiskey", distributor: @distributor)

    @business_item_1 = create(:business_item, business: @business, item: @item_1)
  end

  it 'sends a cocktail recipe for a business item' do

    json_response = File.open('./fixtures/cocktail_object.json')
    url = "/api/v1/cocktails/#{@business_item_1.id}?api_key=#{@business.api_key}"

    response = stub_request(:get, url).to_return(status: 200, body: json_response)

    result = JSON.parse(response.response.body, symbolize_names: true)
    expect(result[:data][:attributes][:ingredients]).to eq("Whiskey, Beer, Lemonade, Ice")
    expect(result[:data][:attributes][:recipe]).to eq('Pour into shot glass. Put in mouth. Repeat as deemed necessary.')
  end

  it 'sends back 404 if invalid api key with get' do
    get "/api/v1/business_items/#{@business_item_1.id}", params: {api_key: 'invalid'}

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    result = JSON.parse(response.body)
    expect(result["error"]).to eq("Couldn't find Business")
  end


  it 'sends back 404 if business item not in DB' do
    get "/api/v1/business_items/0", params: {api_key: @business.api_key}

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    result = JSON.parse(response.body)
    expect(result["error"]).to eq("Couldn't find BusinessItem with 'id'=0")
  end
end
