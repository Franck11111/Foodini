class CreateOrderIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :order_ingredients do |t|
      t.references :order, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
