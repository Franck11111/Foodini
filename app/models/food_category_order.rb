class FoodCategoryOrder < ApplicationRecord
  belongs_to :order
  belongs_to :food_category
end
