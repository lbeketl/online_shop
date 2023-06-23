require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:product) { create(:product, price: 50.5) }
  let!(:order) { create(:order, first_name: "Ivan", last_name: "Ivanov") }
  let!(:product_order) { create(:product_order, product: product, order: order, amount: 2) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:products).through(:product_orders) }
    it { is_expected.to have_many(:product_orders).dependent(:destroy) }
  end

  describe "#full_name" do
    it { expect(order.full_name).to eq("Ivan Ivanov") }
  end

  describe "#total_sum" do
    it { expect(order.total_sum).to eq(101) }
  end

  describe "#total_amount" do
    it { expect(order.total_amount).to eq(2) }
  end
end
