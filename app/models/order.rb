class Order < ApplicationRecord
  belongs_to :user
  has_many :order_meals
  has_many :food_category_orders
  has_many :order_ingredients
  has_many :payments
  monetize :amount_cents
  has_many :meals, through: :order_meals
  has_many :food_categories, through: :food_category_orders

  enum option_category: [:lucky, :cautious]
end
