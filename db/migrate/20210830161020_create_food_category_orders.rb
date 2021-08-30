class CreateFoodCategoryOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :food_category_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :food_category, null: false, foreign_key: true
      t.boolean :desired

      t.timestamps
    end
  end
end
