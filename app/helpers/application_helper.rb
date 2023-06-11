module ApplicationHelper
  def current_cart
    session[:cart] ||= {}
  end

  def is_admin?
    true
  end

  def cart_items_size
    current_cart.empty? ? 0 : current_cart.values.sum
  end
end
