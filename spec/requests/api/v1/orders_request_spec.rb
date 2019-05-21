require 'rails_helper'

describe 'Orders API', :type => :request do
  context 'with a correct API key' do
    it 'creates an order for a successful request' do

      distributor = Distributor.create!(name: 'RNDC',
                                        address: '3319 Arapahoe st, Denver, CO',
                                        code: 'CODE1234',
                                        api_key: 'jgn983hy48thw9begh98h4539h4',
                                        password: 'password'
                                        )

      item_1 = create(:item, distributor: distributor)
      item_2 = create(:item, distributor: distributor)
      business = create(:business, api_key: 'jgn983hy48thw9begh98h4539h4', distributor: distributor)

      params = {'api_key': 'jgn983hy48thw9begh98h4539h4',
                'total_cost': '200',
                'total_revenue': '40',
                'items': [{
                   'id': "#{item_1.id}",
                   'quantity': '4',
                   'price': '25'
                 },
                 {
                    'id': "#{item_2.id}",
                    'quantity': '2',
                    'price': '50'
                  }
               ]
               }

      expect(Order.all.count).to eq(0)

      post '/api/v1/orders', params: params

      result = JSON.parse(response.body)['data']
      # THIS TEST WILL FAIL ONCE MERGED INTO MASTER, AS A REPRESENTATIVE WILL NEED TO
      #  BE CREATED IN THE TEST SETUP AND THE BUSINESS WILL NEED TO HAVE A REPRESENTATIVE

      # UNIT IS HARDCODED INTO THE COntroller RIGHT NOW and will need to either be tested for,
      # and the hardcoded value changed, or the column will need to be removed from the database.

      expect(response.status).to eq(201)
      expect(result).to eq(nil)
      expect(Order.all.count).to eq(1)
      expect(Order.all[0].total_cost).to eq(200.0)
      expect(Order.all[0].total_revenue).to eq(40)
      expect(Order.all[0].items[0].id).to eq(item_1.id)
      expect(Order.all[0].items[1].id).to eq(item_2.id)
      expect(Order.all[0].business_id).to eq(business.id)
      expect(OrderItem.all.count).to eq(2)
      expect(OrderItem.all[0].order_id).to eq(Order.all[0].id)
      expect(OrderItem.all[1].order_id).to eq(Order.all[0].id)
      expect(OrderItem.all[0].item_id).to eq(item_1.id)
      expect(OrderItem.all[1].item_id).to eq(item_2.id)
      expect(OrderItem.all[0].quantity).to eq(4)
      expect(OrderItem.all[1].quantity).to eq(2)
      expect(OrderItem.all[0].price).to eq(25)
      expect(OrderItem.all[1].price).to eq(50)
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

  #Make sure to test that an incorrect api key is giving back the response we want
  # and is not creating an order.
end
