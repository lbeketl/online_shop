class Product < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders

  validates :name, presence: true
  validates :balance, :price, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(created_at: :desc) }
end
