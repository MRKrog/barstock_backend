require 'rails_helper'

describe 'Orders API', :type => :request do
  context 'with a correct API key' do
    it 'sends a list of orders for a successful request' do
      distributor = Distributor.create!(name: 'RNDC',
                                          address: '3319 Arapahoe st, Denver, CO',
                                          code: 'CODE12345',
                                          api_key: 'jgn983hy48thw9begh98h4539h41',
                                          password: 'password'
                                          )

      rep = create(:representative, distributor: distributor)
      business_1 = create(:business, api_key: '111111111', distributor: distributor, representative: rep)

      business_2 = create(:business, api_key: '999999', distributor: distributor, representative: rep)

      order_1 = create(:order, business: business_1)
      create(:order, business: business_2)

      get '/api/v1/orders', params: {'api_key': business_1.api_key}

      result = JSON.parse(response.body)['data']

      expect(response.status).to eq(200)
      expect(result.count).to eq(1)
      expect(result[0]['id']).to eq(order_1.id.to_s)
      expect(result[0]['type']).to eq('order')
      expect(result[0]['attributes']['id']).to eq(order_1.id)
      expect(result[0]['attributes']['total_cost']).to eq(order_1.total_cost)
      expect(result[0]['attributes']['total_revenue']).to eq(order_1.total_revenue)
    end

    it 'sends a message for successful request, but there are no orders in the databse' do
      distributor = Distributor.create!(name: 'RNDC',
                                          address: '3319 Arapahoe st, Denver, CO',
                                          code: 'CODE12345',
                                          api_key: 'jgn983hy48thw9begh98h4539h41',
                                          password: 'password'
                                          )

      rep = create(:representative, distributor: distributor)
      business = create(:business, api_key: '111111111', distributor: distributor, representative: rep)

      get '/api/v1/orders', params: {'api_key': business.api_key}

      result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(result['data']).to eq([])
    end
  end

  context 'with an incorrect API key' do
    it 'responds with a 404 not found status' do

      get '/api/v1/orders', :params => {'api_key': 'incorrect_key'}

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['error']).to eq("Couldn't find Business")
    end
  end
end
