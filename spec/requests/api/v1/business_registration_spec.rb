require 'rails_helper'

	describe 'Business registration API' do
    before :each do
      @distributor = Distributor.create!(name: 'RNDC',
        address: '3319 Arapahoe st, Denver, CO',
        code: 'CODE1234',
        api_key: 'jgn983hy48thw9begh98h4539h4',
        password: 'password'
      )
    end
	  it 'sends back an api key' do
	    post '/api/v1/businesses/register', params: {
					                                          name: 'Cool Bar',
					                                          email: 'whatever@example.com',
						                                        password: 'password',
					                                          phone_number: '1234',
					                                          distributor_code: @distributor.code,
					                                          address: '1 st'
						                                       }

	    expect(response).to be_successful
      expect(response.status).to eq(201)
      business = Business.last
      expect(business.distributor).to eq(@distributor)
      key = JSON.parse(response.body)["api_key"]
      expect(key).to eq(business.api_key)
	  end

    it 'sends back a 422 status if missing information' do

      post '/api/v1/businesses/register', params: {
					                                          email: 'whatever@example.com',
						                                        password: 'password',
					                                          phone_number: '1234',
					                                          distributor_code: @distributor.code,
					                                          address: '1 st'
						                                       }

      expect(response).to_not be_successful
      message = JSON.parse(response.body)
      expect(message).to eq({"name"=>["can't be blank"]})
      expect(response.status).to eq(422)
    end

    it 'sends back a 422 status if email already taken' do
      business = create(:business, distributor: @distributor)
      post '/api/v1/businesses/register', params: {
					                                          name: 'Cool Bar',
					                                          email: business.email,
					                                          password: 'password',
					                                          phone_number: '1234',
					                                          distributor_code: @distributor.code,
					                                          address: '1 st'
					                                         }

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      message = JSON.parse(response.body)
      expect(message).to eq({"email"=>["has already been taken"]})
    end
	end
