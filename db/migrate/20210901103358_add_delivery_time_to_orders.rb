class AddDeliveryTimeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_time, :integer
  end
end
