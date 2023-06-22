class CartsController < ApplicationController
  def show
    @cart_items = cart_manager.cart_items
  end

  def create
    cart_manager.add_item

    redirect_to root_path, notice: 'Product added to cart.'
  end

  def update
    cart_manager.update_item_amount

    redirect_to carts_path, notice: 'Quantity updated.'
  end

  def destroy
    cart_manager.remove_item

    redirect_to carts_path, notice: 'Product removed from cart.'
  end

  private

  def cart_manager
    Carts::CartManager.new(session, params)
  end
end
