# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "json"
require "rest-client"
require 'open-uri'
require 'faker'

# 0. Cleaning database
puts "Cleaning database..."
  #first destroy child
  MealsIngredient.destroy_all
  OrderIngredient.destroy_all
  Ingredient.destroy_all
  FoodCategoryMeal.destroy_all
  FoodCategoryOrder.destroy_all
  FoodCategory.destroy_all
  OrderMeal.destroy_all
  Meal.destroy_all
  Restaurant.destroy_all
  Order.destroy_all
  User.destroy_all

# 1. Creating users
puts "Creating users..."

User.create([{ email: "indira@lewagon.com", password: "Greg123", password_confirmation: "Greg123",
first_name: "Indira", last_name: "Vh", address: "Brussels Central" }])
User.create([{ email: "franck@gmail.com", password: "Franck123", password_confirmation: "Franck123",
first_name: "Franck", last_name: "Dirat", address: "Wielingenstraat 30k" }])

# 2. Creating orders
puts "Creating 5 orders"

Order.create(option_category: 'Feeling lucky', delivery_time: rand(20..60), address: Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'unconfirmed', user_id: 1)
Order.create(option_category: 'Feeling cautious', delivery_time: rand(20..60), address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'confirmed', user_id: 2)
Order.create(option_category: 'Feeling lucky', delivery_time: rand(20..60), address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'unconfirmed', user_id: 3)
Order.create(option_category: 'Feeling cautious', delivery_time: rand(20..60), address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'unconfirmed', user_id: 4)
Order.create(option_category: 'Feeling lucky', delivery_time: rand(20..60), address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'confirmed', user_id: 5)

# 3. Creating ingredients[idingredient]
ingredient_base_url = URI.open('https://www.themealdb.com/api/json/v1/1/list.php?i=list').read
ingredient_list = JSON.parse(ingredient_base_url) # => an `Array` of `Hashes`.

ingredient_list['meals'].each do |idingredient|
  Ingredient.create(name: idingredient['strIngredient'])
end

# 4. Creating food categories
 # 4.1 food_type
food_type_base_url = URI.open('https://www.themealdb.com/api/json/v1/1/list.php?c=list').read
food_type_list = JSON.parse(food_type_base_url) # => an `Array` of `Hashes`.

food_type_list['meals'].each do |category|
 FoodCategory.create(food_type: category['strCategory'])
end
  # 4.2 Creating cuisine_area
cuisine_area_base_url = URI.open('https://www.themealdb.com/api/json/v1/1/list.php?a=list').read
cuisine_area_hash = JSON.parse(cuisine_area_base_url) # => an `Array` of `Hashes`.

cuisine_area_hash['meals'].each do |area|
 food_category = FoodCategory.create(cuisine_area: area['strArea'])
 p food_category

#  food_category.cuisine_area << food_category[cuisine_area]
#  p food_category.cuisine_area
end

# 5. Creating restaurants
puts "Creating 30 restaurants"

10.times do
 restaurant_1 = Restaurant.create(name: Faker::Restaurant.name, address: "Valkenburgerstraat 223D, Amsterdam, Netherlands")
 p restaurant_1
end
10.times do
  restaurant_2 = Restaurant.create(name: Faker::Restaurant.name, address: "Watertorenplein 6, Amsterdam, Netherlands")
  p restaurant_2
end
10.times do
  restaurant_3 = Restaurant.create(name: Faker::Restaurant.name, address: "Lange Leidsedwarsstraat 108, Amsterdam, Netherlands")
  p restaurant_3
end

# 6. Creating meals
cuisine_area_array = cuisine_area_hash['meals'].map { |area| area['strArea'] }
# 👆 is the same as:
  # cuisine_area_array = []
  # cuisine_area_list['meals'].each do |area|
  #   cuisine_area_array << area['strArea']
  # end

cuisine_area_array.each do |area|
  meal_name_url = URI.open("https://www.themealdb.com/api/json/v2/9973533/filter.php?a=#{area}").read
  meals_list_hash = JSON.parse(meal_name_url)

  # 6.1 Create meals
  meals_list_hash['meals'].each do |meal_from_api_hash|
    meal = Meal.new(name: meal_from_api_hash['strMeal'], description: Faker::Food.description, price: rand(15..19), restaurant: Restaurant.all.sample, image: meal_from_api_hash['strMealThumb'])
    api_meal_id = meal_from_api_hash['idMeal']
    complete_meal_url = URI.open("https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{api_meal_id}").read
    complete_meal_hash = JSON.parse(complete_meal_url)
      (1..20).each do |ingredient_nr|
        ingredient_name = complete_meal_hash["meals"][0]["strIngredient#{ingredient_nr}"]
          unless ingredient_name.nil? || ingredient_name.empty?
            ingredient = Ingredient.find_by(name: ingredient_name)
            meal.ingredients << ingredient unless ingredient.nil?
          end
      end
    category_name = complete_meal_hash["meals"][0]["strCategory"]
    add_food_type = FoodCategory.find_by(food_type: category_name)
    meal.food_categories << add_food_type
    area_name = complete_meal_hash["meals"][0]["strArea"]
    add_cuisine_area = FoodCategory.find_by(cuisine_area: area_name)
    meal.food_categories << add_cuisine_area
    meal.save!
    end
  end

# Displaying all orders
  pp Order.all
  puts "Total orders added #{Order.count}"
  puts "Finished!"
