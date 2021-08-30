class RemoveIngredientIdFromOrderIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_ingredients, :ingredient_id, :integer
  end
end
