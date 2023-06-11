class Products::CartManager
  attr_reader :product_id, :amount, :cart

  def initialize(params: {}, cart: {})
    @product_id = params[:product_id]
    @amount = params[:amount] || 1
    @cart = cart
  end

  def add
    if cart.key?(product_id)
      cart[product_id] += 1
    else
      cart[product_id] = amount.to_i
    end
  end

  def cart_items
    cart.transform_keys do |product_id|
      Product.find(product_id)
    end
  end

  def update_amount
    cart[product_id] = amount.to_i if cart.present? && cart[product_id].present?
  end

  def remove
    cart.delete(product_id) if cart.present?
  end
end
