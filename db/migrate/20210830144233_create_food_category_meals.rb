class CreateFoodCategoryMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :food_category_meals do |t|
      t.references :food_category, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
