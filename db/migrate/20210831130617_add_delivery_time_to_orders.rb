class AddDeliveryTimeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_time, :time
  end
end
