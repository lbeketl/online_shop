class ApplicationController < ActionController::Base
  def current_cart
    session[:cart] ||= {}
  end
end
