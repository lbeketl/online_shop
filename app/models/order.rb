class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def full_name
    [first_name, last_name].join(" ")
  end

  def total_sum
    self.class.joins(product_orders: :product)
              .where(id: id)
              .sum('product_orders.amount * products.price')
  end

  def total_amount
    self.class.joins(:product_orders)
            .where(id: id)
            .sum(:amount)
  end
end
