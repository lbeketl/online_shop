class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :amount, numericality: { greater_than_or_equal_to: 1 }

  def product_total_sum
    product.price * amount
  #   self.class.joins(:product)
  #             .where(id: id)
  #             .select("product_orders.amount * products.price AS total_price")
  #             .pluck(:total_price)
  #             .first
  end

end
