require 'rails_helper'

describe 'Business Account API' do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
    @rep = create(:representative, distributor: @distributor)
    @business = create(:business, distributor: @distributor, representative: @rep)
  end

  it 'sends back the business information' do
    get '/api/v1/businesses/account', params: {api_key: @business.api_key}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    result = JSON.parse(response.body)
    expect(result["business"]["data"]["attributes"]["name"]).to eq(@business.name)
    expect(result["business"]["data"]["attributes"]["distributor"]["distributor_name"]).to eq(@distributor.name)
    expect(result["business"]["data"]["attributes"]["representative"]["rep_name"]).to eq(@rep.name)
  end

  it 'sends back 404 if invalid api key' do
    get '/api/v1/businesses/account', params: {api_key: "invalid_api_key"}

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    result = JSON.parse(response.body)
    expect(result["error"]).to eq("Couldn't find Business")
  end


end
