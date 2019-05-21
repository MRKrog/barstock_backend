require 'rails_helper'

describe 'Orders API', :type => :request do
  context 'with a correct API key' do
    it 'creates an order for a successful request' do
      distributor_1 = Distributor.create!(name: 'RNDC',
                                        address: '3319 Arapahoe st, Denver, CO',
                                        code: 'CODE1234',
                                        api_key: 'jgn983hy48thw9begh98h4539h4',
                                        password: 'password'
                                        )

      item_1 = create(:item, distributor: distributor_1)
      item_2 = create(:item, distributor: distributor_1)

      params = {"api_key": "jgn983hy48thw9begh98h4539h4",
                "total_cost": "200",
                "total_revenue": "40",
                "items": [{
                   "id": "1",
                   "quantity": "4"
                 }]
               }
      post '/api/v1/orders', params: params

      result = JSON.parse(response.body)['data']

      expect(response.status).to eq(200)

    end
  end

  # context 'with an incorrect API key' do
  #   it 'responds with a 400 status for bad request' do
  #
  #     get '/api/v1/items', :params => {'api_key': 'incorrect_key'}
  #
  #     expect(response.status).to eq(404)
  #   end
  # end

  # Request fails if missing one of the fields
end
