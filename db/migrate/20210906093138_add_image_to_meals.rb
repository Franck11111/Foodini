class AddImageToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :image, :string
  end
end
