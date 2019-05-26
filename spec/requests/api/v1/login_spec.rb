require 'rails_helper'

describe 'Login API' do
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
  it 'sends back the api key for the business' do

    post '/api/v1/login', params: {
                                    credential: @business.email,
                                    password: @business.password,
                                  }

    expect(response).to be_successful
    expect(response.status).to eq(200)
    result = JSON.parse(response.body)
    expect(result["api_key"]).to eq(@business.api_key)
    expect(result["type"]).to eq("Business")
  end

  it 'sends back a 401 status if invalid password' do

    post '/api/v1/login', params: {
                                    credential: @business.email,
                                    password: "incorrect",
                                  }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    password = JSON.parse(response.body)
    expect(password["unauth"]).to eq('Incorrect Password')
  end

  it 'sends back a 404 status if email not found in DB' do

    post '/api/v1/login', params: {
                                    credential: 'random@mail.com',
                                    password: "no_matter",
                                  }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    message = JSON.parse(response.body)
    expect(message).to eq({"error"=>"Invalid credentials"})
  end

  it 'sends back the api key for the distributor' do

    post '/api/v1/login', params: {
                                                credential: @distributor.name,
                                                password: @distributor.password,
                                              }

    expect(response).to be_successful
    expect(response.status).to eq(200)
    result = JSON.parse(response.body)
    expect(result["api_key"]).to eq(@distributor.api_key)
    expect(result["type"]).to eq("Distributor")

  end

  it 'sends back a 401 status if invalid password' do

    post '/api/v1/login', params: {
                                                credential: @distributor.name,
                                                password: "incorrect",
                                              }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    password = JSON.parse(response.body)
    expect(password["unauth"]).to eq('Incorrect Password')
  end

  it 'sends back a 404 status if name not found in DB' do

    post '/api/v1/login', params: {
                                                credential: 'random@mail.com',
                                                password: "no_matter",
                                              }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    message = JSON.parse(response.body)
    expect(message).to eq({"error"=>"Invalid credentials"})
  end
end
