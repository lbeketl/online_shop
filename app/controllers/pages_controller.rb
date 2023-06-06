class PagesController < ApplicationController
  def home
    @products = Product.order(created_at: :desc)
  end

  def about
  end

  def contact
  end

  def pricing
  end
end
