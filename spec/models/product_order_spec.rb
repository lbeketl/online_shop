require 'rails_helper'

RSpec.describe ProductOrder, type: :model do
  let!(:product) { create(:product, price: 50.5) }
  let!(:product_order) { create(:product_order, product: product, amount: 2) }

  describe "validations" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(1) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe "#product_total_sum" do
    it { expect(product_order.product_total_sum).to eq(101) }
  end
end
