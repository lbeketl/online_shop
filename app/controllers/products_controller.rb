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
    resource.destroy

    redirect_to products_path, notice: "Product has been successfully deleted"
  end

# Cart features
  def add_to_cart
    cart_manager.add

    redirect_to root_path, notice: 'Product added to cart.'
  end

  def show_cart
    @cart_items = cart_manager.cart_items
  end

  def update_amount
    cart_manager.update_amount

    redirect_to cart_path, notice: 'Cart updated.'
  end

  def remove_from_cart
    cart_manager.remove

    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :balance)
  end

  def collection
    Product.all
  end

  def resource
    collection.find(params[:id])
  end

  def cart_manager
    Products::CartManager.new(params: params, cart: session[:cart])
  end
end
