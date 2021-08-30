class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :option_category
      t.string :address
      t.integer :delivery_time
      t.integer :budget
      t.integer :number_of_meals
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
