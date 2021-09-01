class Order < ApplicationRecord
  belongs_to :user
  has_many :order_meals
  has_many :order_ingredients
  has_many :payments
  monetize :amount_cents
end
