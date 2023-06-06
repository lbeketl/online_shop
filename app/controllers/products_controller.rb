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
      redirect_to products_path
      flash[:success] = "Product #{@product.name} has been successfully created"
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
      redirect_to product_url(@product)
      flash[:success] = "Product has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource
    @product.destroy
    redirect_to products_path
    flash[:notice] = "Product has been successfully deleted"
  end

# Cart features
  def add_to_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    current_cart[product_id] ||= 1
    current_cart[product_id] += quantity
    redirect_to root_path, notice: 'Product added to cart.'
  end

  def show_cart
    @cart_items = []
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @cart_items << [product, quantity]
    end
  end

  def update_quantity
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    current_cart[product_id] = quantity if current_cart && current_cart[product_id]
    redirect_to cart_path, notice: 'Cart updated.'
  end

  def remove_from_cart
    product_id = params[:product_id]
    current_cart.delete(product_id) if current_cart
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
