class OrderIngredient < ApplicationRecord
  belongs_to :order
  belongs_to :ingredient
end
