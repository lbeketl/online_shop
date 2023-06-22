class OrdersController < ApplicationController
  def index
    @orders = collection
  end

  def show
    @order = resource
  end

  def new
    @order = Order.new
  end

  def create
    if Orders::OrderManager.new(cart: session[:cart]).check_cart_items
      @order = Order.new(order_params)
      if @order.save
        Orders::OrderManager.new(order: @order, cart: session[:cart]).create_product_orders
        Carts::CartManager.new(session).clear_cart

        redirect_to orders_path, notice: "Order #{@order.id} has been successfully created"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "You cannot create an order because your shopping cart is empty! Please add some products to your cart!"
    end
  end

  def edit
    @order = resource
  end

  def update
    @order = resource
    if @order.update(order_params)

      redirect_to order_url(@order), notice: "Order has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = resource
    @order.destroy

    redirect_to orders_path, notice: "Order has been successfully deleted"
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :phone)
  end

  def collection
    Order.all
  end

  def resource
    collection.find(params[:id])
  end
end
