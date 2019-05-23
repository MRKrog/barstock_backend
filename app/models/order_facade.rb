class OrderFacade

  def self.get_orders(business)
    orders = Order.where(business: business)
    orders.map do |order|
      OrderInfo.new(order)
    end
  end

end
