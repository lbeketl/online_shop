require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { create(:order) }

  describe "Validations" do
    it 'is valid with valid attributes' do
      expect(order).to be_valid
    end

    it 'is not valid with empty firstname field' do
      order.firstname = nil
      expect(order).to_not be_valid
      expect(order.errors[:firstname]).to include("can't be blank")
    end

    it 'is not valid with empty lastname field' do
      order.lastname = nil
      expect(order).to_not be_valid
      expect(order.errors[:lastname]).to include("can't be blank")
    end

    it 'is not valid with empty address field' do
      order.address = nil
      expect(order).to_not be_valid
      expect(order.errors[:address]).to include("can't be blank")
    end

    it 'is not valid with empty phone field' do
      order.phone = nil
      expect(order).to_not be_valid
      expect(order.errors[:phone]).to include("can't be blank")
    end
  end
end
