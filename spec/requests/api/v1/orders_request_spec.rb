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
      business = create(:business, api_key: '111111111', distributor: distributor, representative: rep)

      create(:business, api_key: '999999', distributor: distributor, representative: rep)

      order = create(:order, business: business)

      get '/api/v1/orders', params: {'api_key': business.api_key}

      result = JSON.parse(response.body)['data']

      expect(response.status).to eq(200)
      expect(result['id']).to eq(order.id.to_s)
      expect(result['type']).to eq('order')
      expect(result['attributes']['id']).to eq(order.id)
      expect(result['attributes']['total_cost']).to eq(order.total_cost)
      expect(result['attributes']['total_revenue']).to eq(order.total_revenue)
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
