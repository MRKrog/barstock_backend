require 'rails_helper'

describe 'Business login API' do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
    @business = create(:business, distributor: @distributor)
  end
  it 'sends back the api key for the business' do

    post '/api/v1/businesses/login', params: {
                                                email: @business.email,
                                                password: @business.password,
                                              }

    expect(response).to be_successful
    expect(response.status).to eq(200)
    key = JSON.parse(response.body)
    expect(key["api_key"]).to eq(@business.api_key)

  end

  it 'sends back a 401 status if invalid password' do

    post '/api/v1/businesses/login', params: {
                                                email: @business.email,
                                                password: "incorrect",
                                              }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    password = JSON.parse(response.body)
    expect(password["unauth"]).to eq('Incorrect Password')
  end

  it 'sends back a 404 status if email not found in DB' do

    post '/api/v1/businesses/login', params: {
                                                email: 'random@mail.com',
                                                password: "no_matter",
                                              }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    message = JSON.parse(response.body)
    expect(message).to eq({"error"=>"Couldn't find Business"})
  end
end
