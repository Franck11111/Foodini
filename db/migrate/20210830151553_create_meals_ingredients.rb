class CreateMealsIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :meals_ingredients do |t|
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
