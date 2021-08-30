class CreateOrderMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :order_meals do |t|
      t.integer :meal_id
      t.integer :order_id

      t.timestamps
    end
  end
end
