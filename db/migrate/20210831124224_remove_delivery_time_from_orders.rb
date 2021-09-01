class RemoveDeliveryTimeFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :delivery_time, :string
  end
end
