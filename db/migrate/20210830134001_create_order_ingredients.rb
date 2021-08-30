class CreateOrderIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :order_ingredients do |t|
      t.integer :order_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
