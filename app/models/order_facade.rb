class OrderFacade

  def self.get_orders(business)
    orders = Order.where(business: business)
                  .order(created_at: :desc)
                  binding.pry
    orders.map do |order|
      OrderInfo.new(order)
    end
  end

end
