require 'rails_helper'

describe 'Distributor login API' do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )
  end
  it 'sends back the api key for the distributor' do

    post '/api/v1/distributors/login', params: {
                                                name: @distributor.name,
                                                password: @distributor.password,
                                              }

    expect(response).to be_successful
    expect(response.status).to eq(200)
    key = JSON.parse(response.body)
    expect(key["api_key"]).to eq(@distributor.api_key)

  end

  it 'sends back a 401 status if invalid password' do

    post '/api/v1/distributors/login', params: {
                                                name: @distributor.name,
                                                password: "incorrect",
                                              }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    password = JSON.parse(response.body)
    expect(password["unauth"]).to eq('Incorrect Password')
  end

  it 'sends back a 404 status if name not found in DB' do

    post '/api/v1/distributors/login', params: {
                                                name: 'random@mail.com',
                                                password: "no_matter",
                                              }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    message = JSON.parse(response.body)
    expect(message).to eq({"error"=>"Couldn't find Distributor"})
  end
end
