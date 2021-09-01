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
  # Ingredient.destroy_all # not needed
  Order.destroy_all

# 1. Creating users
puts "Creating users..."

User.create([{ email: "indira@lewagon.com", password: "Greg123", password_confirmation: "Greg123",
first_name: "Indira", last_name: "Vh", address: "Brussels Central" }])

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
  p Ingredient.create(name: idingredient['strIngredient'])
end

# 4. Creating food categories
 # 4.1 food_type
food_type_base_url = URI.open('https://www.themealdb.com/api/json/v1/1/list.php?c=list').read
food_type_list = JSON.parse(food_type_base_url) # => an `Array` of `Hashes`.

food_type_list['meals'].each do |category|
FoodCategory.create(type: category['strcategory'])
end
  # 4.2 Creating cuisine_area
cuisine_area_base_url = URI.open('https://www.themealdb.com/api/json/v1/1/list.php?a=list').read
cuisine_area_list = JSON.parse(cuisine_area_base_url) # => an `Array` of `Hashes`.

cuisine_area_list['meals'].each do |area|
 p FoodCategory.create(cuisine_area: area['strarea'])
end

# 5. Creating restaurants
puts "Creating 5 restaurants"
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)

# 6. Creating meals

meal_name_url = URI.open('https://www.themealdb.com/api/json/v2/9973533/filter.php?a=Canadian').read
meals_list = JSON.parse(meal_name_url)
# 6.1 Create meals
meals_list['meals'].each do |meal_from_api_hash|
  p Meal.create(name: meal_from_api_hash['strMeal'], description: Faker::Food.description, price: rand(15..40), restaurant_id: 1)
end
# # 6.2 Add ingredient to meal
# meal.ingredients << Ingredient.find_by name: meal_api_ingredient_name


# Displaying all orders
 pp Order.all
  puts "Total orders added #{Order.count}"
  puts "Finished!"
