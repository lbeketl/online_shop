class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  default_scope { order(created_at: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_sum
    product_orders.reduce(0) do |total, i|
      total + i.amount * i.product.price
    end
  end

  def total_amount
    product_orders.reduce(0) { |total, i| total + i.amount }
  end
end
