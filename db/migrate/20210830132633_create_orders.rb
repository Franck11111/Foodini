class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_option_category
      t.integer :delivery_time
      t.integer :budget
      t.integer :number_of_meals
      t.string :address
      t.integer :user_id

      t.timestamps
    end
  end
end
