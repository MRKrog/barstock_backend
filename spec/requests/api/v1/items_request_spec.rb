require 'rails_helper'

describe 'Items API', :type => :request do
  context 'with a correct API key' do
    it 'sends a list of items for the succesful request' do
      body = {'api_key': 'jgn983hy48thw9begh98h4539h4'}

      get '/api/v1/items', params: body

      # result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response.body['data']['attributes']['alc_type'][0]).to have_key('beer')
      expect(response.body['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('name')
      expect(response.body['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('price')
      expect(response.body['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('ounces')
      expect(response.body['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('unit')
      expect(response.body['data']['attributes']['alc_type'][0]['beer']['alc_category'][0]['porter']).to have_key('thumbnail')
      expect(response.body['data']['attributes']['alc_type'][1]).to have_key('liquor')
      expect(response.body['data']['attributes']['alc_type'][2]).to have_key('wine')
    end
  end

  context 'with an incorrect API key' do
    it 'responds with a 401 unauthorized status' do

      get '/api/v1/items', :body => {'api_key': 'incorrect_key'}

      expect(response.status).to eq(401)
    end
  end
end
