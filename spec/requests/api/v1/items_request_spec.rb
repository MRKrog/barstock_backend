require 'rails_helper'

describe 'Items API', :type => :request do
  context 'with a correct API key' do
    distributor_1 = Distributor.create!(name: 'RNDC',
                                      address: '3319 Arapahoe st, Denver, CO',
                                      distributor_code: 'CODE1234',
                                      api_key: 'jgn983hy48thw9begh98h4539h4',
                                      password: 'password'
                                      )
    distributor_2 = Distributor.create!(name: 'Other',
                                      address: 'other',
                                      distributor_code: 'other',
                                      api_key: 'other',
                                      password: 'other'
                                      )

    business_1 = create(:business, api_key: '111111111', distributor: distributor_1)
    business_2 = create(:business, api_key: '999999', distributor: distributor_2)

    item_1 = create(:item, distributor: distributor_1)
    item_2 = create(:item, distributor: distributor_1)
    item_3 = create(:item, distributor: distributor_2)

    it 'sends a list of items for the succesful request' do

      get '/api/v1/items', params: {'api_key': 'jgn983hy48thw9begh98h4539h4'}

      result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(result['data']['attributes']['alc_type'].count).to eq(2)
      expect(result['data']['attributes']['alc_type'][0]['id']).to eq(item_1.id)
      expect(result['data']['attributes']['alc_type'][1]['id']).to eq(item_2.id)
      expect(result['data']['attributes']['alc_type'][0]).to have_key('beer')
      expect(result['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('name')
      expect(result['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('price')
      expect(result['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('ounces')
      expect(result['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('unit')
      expect(result['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('thumbnail')
      expect(result['data']['attributes']['alc_type'][1]).to have_key('liquor')
      expect(result['data']['attributes']['alc_type'][2]).to have_key('wine')
    end
  end

  context 'with an incorrect API key' do
    it 'responds with a 401 unauthorized status' do

      get '/api/v1/items', :params => {'api_key': 'incorrect_key'}

      expect(response.status).to eq(401)
    end
  end
end
