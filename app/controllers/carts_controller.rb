class CartsController < ApplicationController
  def show
    @cart_items = Carts::CartManager.new(session, params).cart_items
  end

  def create
    Carts::CartManager.new(session, params).add_item

    redirect_to root_path, notice: 'Product added to cart.'
  end

  def update
    Carts::CartManager.new(session, params).update_item_amount

    redirect_to carts_path, notice: 'Quantity updated.'
  end

  def destroy
    Carts::CartManager.new(session, params).remove_item

    redirect_to carts_path, notice: 'Product removed from cart.'
  end
end
