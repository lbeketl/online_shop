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
