module CartHelper
  def cart_items_size
    session[:cart].blank? ? 0 : session[:cart].values.sum
  end

  def product_total_sum
    return 0 if session[:cart].count.zero?
      s = 0
      session[:cart].each do |product_id, quantity|
        product = Product.find(product_id)
        s+= product.price * quantity
      end
      s
  end
end
