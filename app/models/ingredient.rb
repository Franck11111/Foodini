class Ingredient < ApplicationRecord
  has_many :order_ingredients
end
