class Orders::OrderManager
  def initialize(order: {}, cart: {})
    @order = order
    @cart = cart
  end

  def create_product_orders
    cart.each { |product_id, amount| order.product_orders.create(product_id:, amount:) }
  end

  def check_cart_items
    cart.keys.count > 0 ? true : false
  end

  private

  attr_reader :order, :cart
end
