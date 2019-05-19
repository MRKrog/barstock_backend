require 'rails_helper'

describe 'Items API', :type => :request do
  context 'with a correct API key' do
    it 'sends a list of items for a successful request' do
      distributor_1 = Distributor.create!(name: 'RNDC',
                                          address: '3319 Arapahoe st, Denver, CO',
                                          distributor_code: 'CODE12345',
                                          api_key: 'jgn983hy48thw9begh98h4539h41',
                                          password: 'password'
                                          )
      distributor_2 = Distributor.create!(name: 'Other',
                                          address: 'other',
                                          distributor_code: 'other',
                                          api_key: 'other',
                                          password: 'other'
                                          )

      business_1 = create(:business, api_key: '111111111', distributor: distributor_1)
      create(:business, api_key: '999999', distributor: distributor_2)

      item_1 = create(:item, distributor: distributor_1)
      item_2 = create(:item, distributor: distributor_1)
      create(:item, distributor: distributor_2)

      get '/api/v1/items', params: {'api_key': business_1.api_key}

      result = JSON.parse(response.body)['data']

      expect(response.status).to eq(200)

      expect(result.count).to eq(2)

      expect(result[0]['id']).to eq(item_1.id.to_s)
      expect(result[1]['id']).to eq(item_2.id.to_s)

      expect(result[0]['type']).to eq('item')
      expect(result[1]['type']).to eq('item')

      expect(result[0]['attributes']['alc_type']).to eq(item_1.alc_type)
      expect(result[0]['attributes']['alc_category']).to eq(item_1.alc_category)
      expect(result[0]['attributes']['name']).to eq(item_1.name)
      expect(result[0]['attributes']['price']).to eq(item_1.price)
      expect(result[0]['attributes']['ounces']).to eq(item_1.ounces)
      expect(result[0]['attributes']['unit']).to eq(item_1.unit)
      expect(result[0]['attributes']['thumbnail']).to eq(item_1.thumbnail)
    end
  end

  context 'with an incorrect API key' do
    it 'responds with a 404 not found status' do

      get '/api/v1/items', :params => {'api_key': 'incorrect_key'}

      expect(response.status).to eq(404)
    end
  end
end
