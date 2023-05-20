require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) { create(:product) }

  describe "Validations" do
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid with empty name field' do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end

    it 'is not valid with empty description field' do
      product.description = nil
      expect(product).to_not be_valid
      expect(product.errors[:description]).to include("can't be blank")
    end

    it 'is not valid with 0 price field' do
      product.price = 0
      expect(product).to_not be_valid
      expect(product.errors[:price]).to include("must be greater than 0")
    end

    it 'is not valid with negative balance field' do
      product.balance = -1
      expect(product).to_not be_valid
      expect(product.errors[:balance]).to include("must be greater than or equal to 0")
    end
  end
end
