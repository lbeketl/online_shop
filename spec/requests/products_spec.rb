require 'rails_helper'

RSpec.describe "/products", type: :request do
  let!(:product) { create(:product) }

  let(:new_attributes) { { product: attributes_for(:product) } }
  let(:valid_attributes) { { product: attributes_for(:product) } }
  let(:invalid_attributes) { { product: attributes_for(:product, :invalid) } }

  describe "GET /index" do
    it "renders a successful response" do
      get products_path

      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_product_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect { post products_path, params: { product: valid_attributes[:product] } }.to change(Product, :count).by(1)
      end

      it "redirects to the created product" do
        post products_path, params: { product: valid_attributes[:product] }

        expect(response).to redirect_to(products_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Product" do
        expect { post products_path, params: invalid_attributes }.to change(Product, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post products_path, params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested product" do
        patch product_path(product), params: { product: new_attributes[:product] }

        product.reload

        expect(controller.notice).to eq("Product has been successfully updated.")
        expect(product.name).to eq(new_attributes[:product][:name])
      end

      it "redirects to the product" do
        patch product_path(product), params: { product: new_attributes[:product] }

        product.reload
        expect(response).to redirect_to(product_path(product))
        expect(product.name).to eq(new_attributes[:product][:name])
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch product_path(product), params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        expect(product.name).not_to eq(invalid_attributes[:product][:name])
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested product" do
      expect { delete product_path(product) }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete product_path(product)

      expect(response).to redirect_to(products_path)
    end
  end
end
