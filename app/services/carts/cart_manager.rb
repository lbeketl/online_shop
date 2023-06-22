class Carts::CartManager
  attr_reader :session, :product_id, :amount

  def initialize(session, params = {})
    @session = session
    @session[:cart] ||= {}
    @product_id = params[:id]
    @amount = params[:amount] || 1
  end

  def cart_items
    session[:cart].transform_keys do |product_id|
      Product.find(product_id)
    end
  end

  def add_item
    if session[:cart].key?(product_id)
      session[:cart][product_id] += 1
    else
      session[:cart][product_id] = amount.to_i
    end
  end

  def remove_item
    session[:cart].delete(product_id) if session[:cart].present?
  end

  def update_item_amount
    session[:cart][product_id] = amount.to_i
  end

  def clear_cart
    session[:cart] = nil
  end
end
