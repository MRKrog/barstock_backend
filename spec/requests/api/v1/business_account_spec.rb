require 'rails_helper'

describe 'Business Account API' do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
    @business = create(:business, distributor: @distributor)
  end

  it 'sends back the business information' do
    get '/api/v1/businesses/account', params: {api_key: @business.api_key}

    expect(response).to be_successful
    expect(response.status).to eq(200)
    result = JSON.parse(response.body)


  end


end
