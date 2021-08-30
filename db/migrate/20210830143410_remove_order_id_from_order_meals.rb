class RemoveOrderIdFromOrderMeals < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_meals, :order_id, :integer
  end
end
