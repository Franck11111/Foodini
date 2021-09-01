class AddAmountToOrders < ActiveRecord::Migration[6.0]
  def change
    add_monetize :orders, :amount, currency: { present: false }
  end
end
