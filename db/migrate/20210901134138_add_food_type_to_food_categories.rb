class AddFoodTypeToFoodCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :food_categories, :food_type, :string
  end
end
