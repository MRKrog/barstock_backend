class OrderInfo
  attr_reader :id,
              :total_cost,
              :items

  def initialize(order)
    @id = order.id
    @total_cost = order.total_cost
    @items = get_items(order.order_items)
  end


  def get_items(order_items)
    order_items.map do |oi|
      {id: oi.item.id, quantity: oi.quantity}
    end
  end

end
