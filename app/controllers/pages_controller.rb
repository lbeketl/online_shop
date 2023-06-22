class PagesController < ApplicationController
  def home
    @products = collection
  end

  def about
  end

  def contact
  end

  def pricing
  end

  private

  def collection
    Product.ordered
  end
end
