module ApplicationHelper
  def is_admin?
    true
  end

  def current_cart
    session[:cart]
  end

  def cart_items_size
    !current_cart ? 0 : current_cart.values.sum
  end
end
