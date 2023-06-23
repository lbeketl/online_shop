require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let!(:product) { create(:product) }

  describe "GET /carts" do
    it "renders the carts page" do
      get carts_path

      expect(response).to be_successful
    end
  end

  describe "POST /carts/:id" do
    it "adds the product to the cart" do
      post cart_path(product)

      expect(session[:cart][product.id.to_s]).to be_present
      expect(flash[:notice]).to eq("Product added to cart.")
    end
  end

  describe "PUT /carts/:id" do
    let(:amount) { 2 }

    it "updates the product amount in the cart" do
      put cart_path(product), params: { id: product.id, amount: }

      expect(session[:cart][product.id.to_s]).to eq(amount)
      expect(flash[:notice]).to eq("Quantity updated.")
    end
  end

  describe "DELETE /carts/:id" do
    it "removes the product from the cart" do
      delete cart_path(product), params: { id: product.id}

      expect(session[:cart][product.id]).to be_nil
      expect(flash[:notice]).to eq("Product removed from cart.")
    end
  end
end
