class RemoveTypeFromFoodCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :food_categories, :type, :string
  end
end
