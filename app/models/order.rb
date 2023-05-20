class Order < ApplicationRecord
  validates :firstname, :lastname, :address, :phone, presence: true
end
