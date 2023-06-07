class Products::CartManager
  def initialize(params:, cart: {})
    @product_id = params[:product_id]
    @amount = params[:amount].to_i
    @cart = cart
  end

  def add_product
    cart[product_id] ||= 1
    cart[product_id] += amount
  end

  def update_amount
    cart[product_id] = amount if cart && cart[product_id]
  end

  private

  attr_reader :product_id, :amount, :cart
end
