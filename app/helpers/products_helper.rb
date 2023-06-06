module ProductsHelper
  def product_total_sum
    if current_cart.keys.count > 0
      s = 0
      current_cart.each do |product_id, quantity|
        product = Product.find(product_id)
        s+= product.price * quantity
      end
      s
    else
      0
    end
  end
end
