class AddRestaurantToMeals < ActiveRecord::Migration[6.0]
  def change
    add_reference :meals, :restaurant, null: false, foreign_key: true
  end
end
