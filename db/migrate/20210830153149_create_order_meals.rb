class CreateOrderMeals < ActiveRecord::Migration[6.0]
  def change
    create_table :order_meals do |t|
      t.references :order, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
