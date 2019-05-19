require 'rails_helper'

	describe 'Business API' do
	  it 'sends back an api key' do

      distributor = Distributor.create!(name: 'RNDC',
        address: '3319 Arapahoe st, Denver, CO',
        code: 'CODE1234',
        api_key: 'jgn983hy48thw9begh98h4539h4',
        password: 'password'
      )

	    post '/api/v1/businesses', params: {
                                          name: 'Cool Bar',
                                          email: 'whatever@example.com',
	                                        password: 'password',
                                          phone_number: '1234',
                                          distributor_code: distributor.code,
                                          address: '1 st'
	                                       }

	    expect(response).to be_successful
      expect(response.status).to eq(201)
      business = Business.last
      expect(business.distributor).to eq(distributor)
      key = JSON.parse(response.body)["api_key"]
      expect(key).to eq(business.api_key)
	  end
	end
