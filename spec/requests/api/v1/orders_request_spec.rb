require 'rails_helper'

describe 'Orders API', :type => :request do
  before :each do
    @distributor = Distributor.create!(name: 'RNDC',
      address: '3319 Arapahoe st, Denver, CO',
      code: 'CODE1234',
      api_key: 'jgn983hy48thw9begh98h4539h4',
      password: 'password'
    )

    @item_1 = create(:item, distributor: @distributor)
    @item_2 = create(:item, distributor: @distributor)
    @rep = create(:representative, distributor: @distributor)
    @business = create(:business, distributor: @distributor, representative: @rep)
    @business_2 = create(:business, distributor: @distributor, representative: @rep)
    @order_1 = create(:order, business: @business)
    @order_2 = create(:order, business: @business)
  end

  context 'with a correct API key' do
    it 'sends a list of orders for a successful request' do

      get '/api/v1/orders', params: {'api_key': @business.api_key}

      result = JSON.parse(response.body)['data']
      expect(response.status).to eq(200)
      expect(result.count).to eq(2)
      expect(result[0]['id']).to eq(@order_1.id.to_s)
      expect(result[0]['type']).to eq('order')
      expect(result[0]['attributes']['id']).to eq(@order_1.id)
      expect(result[0]['attributes']['total_cost']).to eq(@order_1.total_cost)
      expect(result[0]['attributes']['total_revenue']).to eq(@order_1.total_revenue)
    end

    it 'sends a message for successful request, but there are no orders in the database' do

      get '/api/v1/orders', params: {'api_key': @business_2.api_key}

      result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(result['data']).to eq([])
    end

    it 'creates an order for a successful request' do

      body = {
              "api_key": @business_2.api_key,
              "total_cost": "200",
              "total_revenue": "4",
              "items": [
                {
                  "id": @item_1.id,
                  "quantity": "4",
                  "price": "5.8"
                },
                {
                  "id": @item_2.id,
                  "quantity": "2",
                  "price": "20"
                }
              ]
            }

      expect(@business_2.orders.count).to eq(0)

      post '/api/v1/orders', params: body
      result = JSON.parse(response.body)['data']

      expect(response.status).to eq(201)
      expect(result).to eq(nil)
      expect(@business_2.orders.count).to eq(1)
      expect(@business_2.orders[0].total_cost).to eq(body[:total_cost].to_f)
      expect(@business_2.orders[0].total_revenue).to eq(body[:total_revenue].to_f)
      expect(@business_2.orders[0].items[0].id).to eq(@item_1.id)
      expect(@business_2.orders[0].items[1].id).to eq(@item_2.id)
      expect(@business_2.orders[0].business_id).to eq(@business_2.id)
      expect(OrderItem.all.count).to eq(2)
      expect(@business_2.order_items[0].order_id).to eq(@business_2.orders[0].id)
      expect(@business_2.order_items[1].order_id).to eq(@business_2.orders[0].id)
      expect(@business_2.order_items[0].item_id).to eq(@item_1.id)
      expect(@business_2.order_items[1].item_id).to eq(@item_2.id)
      expect(@business_2.order_items[0].quantity).to eq(4)
      expect(@business_2.order_items[1].quantity).to eq(2)
      expect(@business_2.order_items[0].price).to eq(5.8)
      expect(@business_2.order_items[1].price).to eq(20.0)
    end

    it 'responds with a 422 status for bad request due to missing total_cost and total_revenue' do

      params = {'api_key': @business.api_key,
                'items': [{
                   'id': "#{@item_1.id}",
                   'price': '25'
                 },
                 {
                    'id': "#{@item_2.id}",
                    'quantity': '2',
                    'price': '50'
                  }
               ]
               }

      post '/api/v1/orders', :params => params

      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['total_cost']).to eq(["can't be blank", "is not a number"])
      expect(JSON.parse(response.body)['total_revenue']).to eq(["can't be blank", "is not a number"])
    end

    it 'responds with a 422 status for bad request due to missing order_item quantity and price' do

      params = {'api_key': @business.api_key,
                'total_cost': '200',
                'total_revenue': '40',
                'items': [{
                   'id': "#{@item_1.id}"
                 },
                 {
                    'id': "#{@item_2.id}",
                    'quantity': '2',
                    'price': '50'
                  }
               ]
               }

      post '/api/v1/orders', :params => params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['price']).to eq(["can't be blank", "is not a number"])
      expect(JSON.parse(response.body)['quantity']).to eq(["can't be blank", "is not a number"])
    end

    it 'responds with a 404 status' do
      params = {'api_key': 'incorrect_key',
                'total_cost': '200',
                'total_revenue': '40',
                'items': [{
                   'id': "#{@item_1.id}",
                   'quantity': '4',
                   'price': '25'
                 },
                 {
                    'id': "#{@item_2.id}",
                    'quantity': '2',
                    'price': '50'
                  }
               ]
               }

      post '/api/v1/orders', :params => params
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
