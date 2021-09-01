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
  Ingredient.destroy_all
  Order.destroy_all

# 1. Creating users
puts "Creating users..."

User.create([{ email: "indira@lewagon.com", password: "Greg123", password_confirmation: "Greg123",
first_name: "Indira", last_name: "Vh", address: "Brussels Central" }])

# 2. Creating orders
puts "Creating 5 orders"

Order.create(option_category: 'Feeling lucky', delivery_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short).min, address: Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'unconfirmed', user_id: 1)
Order.create(option_category: 'Feeling cautious', delivery_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short).min, address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'confirmed', user_id: 2)
Order.create(option_category: 'Feeling lucky', delivery_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short).min, address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'unconfirmed', user_id: 3)
Order.create(option_category: 'Feeling cautious', delivery_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short).min, address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'', user_id: 4)
Order.create(option_category: 'Feeling lucky', delivery_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short).min, address:Faker::Address.street_address, budget: rand(15..40), number_of_meals: rand(1..10), status:'confirmed', user_id: 5)

# 3. Creating ingredients
ingredient_base_url = RestClient.get 'https://www.themealdb.com/api/json/v1/1/list.php?i=list'
ingredient_list = JSON.parse(ingredient_base_url) # => an `Array` of `Hashes`.

ingredient_list.each do |idingredient|
  Ingredient.create(ingredient: ingredient_list['meals'][idingredient]['strIngredient'])
end

# 4. Food categories
  # 4.1 food_type
food_type_base_url = RestClient.get 'https://www.themealdb.com/api/json/v1/1/list.php?c=list'
food_type_list = JSON.parse(food_type_base_url) # => an `Array` of `Hashes`.

food_type_list.each do |strcategory|
  Ingredient.create(food_type: food_type_list['meals'][strcategory])
end
  # 4.2 cuisine_area
cuisine_area_base_url = RestClient.get 'https://www.themealdb.com/api/json/v1/1/list.php?a=list'
cuisine_area_list = JSON.parse(cuisine_area_base_url) # => an `Array` of `Hashes`.

cuisine_area_list.each do |strarea|
  Ingredient.create(cuisine_area: cuisine_area_list['meals'][strarea])
end

# 5. Restaurant
puts "Creating 5 restaurants"
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)
Restaurant.create(name: Faker::Restaurant.name, address: Faker::Address.street_address)

# Displaying all orders
 pp Order.all
  puts "Total orders added #{Order.count}"
  puts "Finished!"
