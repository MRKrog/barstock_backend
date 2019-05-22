require 'rails_helper'

describe 'Items GET API', :type => :request do
  context 'with a correct API key' do
    it 'sends a list of items for a successful request' do
      distributor_1 = Distributor.create!(name: 'RNDC',
                                          address: '3319 Arapahoe st, Denver, CO',
                                          code: 'CODE12345',
                                          api_key: 'jgn983hy48thw9begh98h4539h41',
                                          password: 'password'
                                          )
      distributor_2 = Distributor.create!(name: 'Other',
                                          address: 'other',
                                          code: 'other',
                                          api_key: 'other',
                                          password: 'other'
                                          )

      rep = create(:representative, distributor: distributor_1)

      business_1 = create(:business, api_key: '111111111', distributor: distributor_1, representative: rep)
      create(:business, api_key: '999999', distributor: distributor_2, representative: rep)

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

describe 'Items POST API', :type => :request do
  context 'with a correct API key' do
    it 'create an item in the database and returns a 201 status with a successful request' do
      distributor = Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                          name: 'RNDC',
                          api_key: 'f01zdxN0RGWufApdZQxwUg',
                          password: 'password',
                          code: 'RNDC1234'
                          )

      params = {
                  'api_key': distributor.api_key,
                  'name': 'name',
                  'alc_type': 'type',
                  'alc_category': 'category',
                  'price': '3',
                  'quantity': '4',
                  'ounces': '3.3',
                  'unit': '3',
                  'thumbnail': 'url'
                }

      expect(Item.all.count).to eq(0)

      post '/api/v1/items', params: params

      expect(Item.all.count).to eq(1)
      expect(Item.all[0].name).to eq('name')
      expect(Item.all[0].alc_type).to eq('type')
      expect(Item.all[0].alc_category).to eq('category')
      expect(Item.all[0].price).to eq(3)
      expect(Item.all[0].quantity).to eq(4)
      expect(Item.all[0].ounces).to eq(3.3)
      expect(Item.all[0].unit).to eq("3")
      expect(Item.all[0].thumbnail).to eq('url')

      expect(response.status).to eq(201)
    end

    it 'returns a 422 status if the params are missing fields to create the item' do
      distributor = Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                          name: 'RNDC',
                          api_key: 'f01zdxN0RGWufApdZQxwUg',
                          password: 'password',
                          code: 'RNDC1234'
                          )

      params = {
                  'api_key': distributor.api_key,
                }

      expect(Item.all.count).to eq(0)

      post '/api/v1/items', params: params

      expect(Item.all.count).to eq(0)

      expect(response.status).to eq(422)

      message_1 = ["can't be blank"]
      message_2 = ["can't be blank", "is not a number"]

      expect(JSON.parse(response.body)['name']).to eq(message_1)
      expect(JSON.parse(response.body)['alc_type']).to eq(message_1)
      expect(JSON.parse(response.body)['alc_category']).to eq(message_1)
      expect(JSON.parse(response.body)['price']).to eq(message_2)
      expect(JSON.parse(response.body)['ounces']).to eq(message_2)
      expect(JSON.parse(response.body)['unit']).to eq(message_1)
      expect(JSON.parse(response.body)['quantity']).to eq(message_2)
    end
  end

  context 'with an invalid API key' do
    it 'sends a 404 response' do
      params = {
                  'api_key': 'incorrect key',
                  'name': 'name',
                  'alc_type': 'type',
                  'alc_category': 'category',
                  'price': '3',
                  'quantity': '4',
                  'ounces': '3.3',
                  'unit': '3',
                  'thumbnail': 'url'
                }

      post '/api/v1/items', params: params

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['error']).to eq("Couldn't find Distributor")
    end
  end
end

describe 'Items UPDATE API', :type => :request do
  context 'with a correct API key' do
    it 'update an item in the database and returns a 200 status with a successful request' do
      distributor = Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                          name: 'RNDC',
                          api_key: 'f01zdxN0RGWufApdZQxwUg',
                          password: 'password',
                          code: 'RNDC1234'
                          )
      item = create(:item, distributor: distributor)

      name = 'update name'
      type = 'update type'
      category = 'update category'
      price = '300'
      quantity = '400'
      ounces = '27.3'
      unit = '500'
      thumbnail = 'url updated'

      params = {
                  'api_key': distributor.api_key,
                  'name': name,
                  'alc_type': type,
                  'alc_category': category,
                  'price': '300',
                  'quantity': '400',
                  'ounces': '27.3',
                  'unit': '500',
                  'thumbnail': 'url updated'
                }

      patch "/api/v1/items/#{item.id}", params: params

      result = JSON.parse(response.body)['data']

      expect(response.status).to eq(200)
      expect(result['id']).to eq(item.id.to_s)
      expect(result['type']).to eq('item')
      expect(result['attributes']['name']).to eq(name)
      expect(result['attributes']['alc_type']).to eq('update type')
      expect(result['attributes']['alc_category']).to eq('update category')
      expect(result['attributes']['price']).to eq(300)
      expect(result['attributes']['quantity']).to eq(400)
      expect(result['attributes']['ounces']).to eq(27.3)
      expect(result['attributes']['unit']).to eq('500')
      expect(result['attributes']['thumbnail']).to eq('url updated')

      expect(Item.find(item.id).name).to eq(name)
      expect(Item.find(item.id).alc_type).to eq(type)
      expect(Item.find(item.id).alc_category).to eq(category)
      expect(Item.find(item.id).price).to eq(price.to_f)
      expect(Item.find(item.id).quantity).to eq(quantity.to_i)
      expect(Item.find(item.id).ounces).to eq(ounces.to_f)
      expect(Item.find(item.id).unit).to eq(unit)
      expect(Item.find(item.id).thumbnail).to eq(thumbnail)
    end

    it 'returns a 404 response with invalid item id' do
      distributor = Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                          name: 'RNDC',
                          api_key: 'f01zdxN0RGWufApdZQxwUg',
                          password: 'password',
                          code: 'RNDC1234'
                          )
      params = {
                  'api_key': "#{distributor.api_key}",
                  'name': 'name',
                  'alc_type': 'type',
                  'alc_category': 'category',
                  'price': '3',
                  'quantity': '4',
                  'ounces': '3.3',
                  'unit': '3',
                  'thumbnail': 'url'
                }

      patch "/api/v1/items/99999999999", params: params

      expect(response.status).to eq(404)
    end
  end

  context 'with an invalid API key' do
    it 'sends a 404 response' do
      distributor = Distributor.create!(address: '8000 Southpark Terrace, Littleton, CO 80120',
                          name: 'RNDC',
                          api_key: 'f01zdxN0RGWufApdZQxwUg',
                          password: 'password',
                          code: 'RNDC1234'
                          )
      item = create(:item, distributor: distributor)

      params = {
                  'api_key': 'incorrect key'
                }

      patch "/api/v1/items/#{item.id}", params: params

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['error']).to eq("Couldn't find Distributor")
    end
  end
end
