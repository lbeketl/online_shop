class Orders::OrderManager
  attr_reader :order, :cart

  def initialize(order: {}, cart: {})
    @order = order
    @cart = cart
  end

  def create_product_orders
    cart.each { |product_id, amount| order.product_orders.create(product_id:, amount:) }
  end
end
