class OrderInfo
  attr_reader :id,
              :total_cost,
              :total_revenue,
              :items

  def initialize(order)
    @id = order.id
    @total_cost = order.total_cost
    @total_revenue = order.total_revenue
    @items = order.items
  end
end
