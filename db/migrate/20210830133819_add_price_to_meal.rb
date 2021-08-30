class AddPriceToMeal < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :price, :integer
  end
end
