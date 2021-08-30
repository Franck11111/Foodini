class RemoveMealIdFromOrderMeals < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_meals, :meal_id, :integer
  end
end
