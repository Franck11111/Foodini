class Order < ApplicationRecord
  belongs_to :user
  has_many :order_meals
  has_many :food_category_orders
  has_many :order_ingredients
  has_many :payments
  monetize :amount_cents
  has_many :meals, through: :order_meals
  has_many :food_categories, through: :food_category_orders
  has_many :ingredients, through: :order_ingredients

  def meals_proposition
    meals_count = Hash.new(0)
    meals = []
    self.food_categories.each{|fc| meals << fc.meals } #get all meals that belongs to food categories, that have been selected
    self.ingredients.each{|i| meals << i.meals }
    meals.flatten!
    meals.each {|meal| meals_count[meal] += 1}
    meals_count.sort_by{|m,count| -count}
  end
end
