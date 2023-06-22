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
end
