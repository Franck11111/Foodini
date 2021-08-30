class CreateFoodCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :food_categories do |t|
      t.string :cuisine_area
      t.string :type

      t.timestamps
    end
  end
end
