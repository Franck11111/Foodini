class RemoveOrderIdFromOrderIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_ingredients, :order_id, :integer
  end
end
