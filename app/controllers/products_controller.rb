class ProductsController < ApplicationController
  def index
    @products = collection
  end

  def show
    @product = resource
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save

      redirect_to products_path, notice: "Product #{@product.name} has been successfully created"
    else
       render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = resource
  end

  def update
    @product = resource
    if @product.update(product_params)

      redirect_to product_url(@product), notice:  "Product has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_cart[resource.id] && current_cart.delete(resource.id)
    resource.destroy

    redirect_to products_path, notice: "Product has been successfully deleted"
  end

# Cart features
  def add_to_cart
    Products::CartManager.new(params: params, cart: current_cart).add_product

    redirect_to root_path, notice: 'Product added to cart.'
  end

  def show_cart
    @cart_items = []
    current_cart.each do |product_id, amount|
      product = Product.find_by(id: product_id)
      @cart_items << [product, amount]
    end
  end

  def update_amount
    Products::CartManager.new(params: params, cart: current_cart).update_amount

    redirect_to cart_path, notice: 'Cart updated.'
  end

  def remove_from_cart
    current_cart.delete(params[:product_id]) if current_cart

    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :balance)
  end

  def collection
    Product.order(created_at: :desc)
  end

  def resource
    collection.find(params[:id])
  end
end
