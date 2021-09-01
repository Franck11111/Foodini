class ChangePriceToBeCurrencyInMeals < ActiveRecord::Migration[6.0]
  def change
    add_monetize :meals, :price, currency: { present: false }
  end
end
