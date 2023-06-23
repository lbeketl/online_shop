class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :amount, numericality: { greater_than_or_equal_to: 1 }

  def product_total_sum
    self.class.joins(:product)
              .where(id: id)
              .sum("products.price * product_orders.amount")
  end
end
