class OrderDetail < ApplicationRecord
  belongs_to :order, dependent: :destroy
  belongs_to :product
end
