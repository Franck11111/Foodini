class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :status
      t.string :delivery_address
      t.integer :order_id

      t.timestamps
    end
  end
end
