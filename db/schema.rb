# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 2021_09_01_134138) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "food_categories", force: :cascade do |t|
    t.string "cuisine_area"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "food_type"
  end

  create_table "food_category_meals", force: :cascade do |t|
    t.bigint "food_category_id", null: false
    t.bigint "meal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_category_id"], name: "index_food_category_meals_on_food_category_id"
    t.index ["meal_id"], name: "index_food_category_meals_on_meal_id"
  end

  create_table "food_category_orders", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "food_category_id", null: false
    t.boolean "desired"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_category_id"], name: "index_food_category_orders_on_food_category_id"
    t.index ["order_id"], name: "index_food_category_orders_on_order_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
    t.bigint "restaurant_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["restaurant_id"], name: "index_meals_on_restaurant_id"
  end

  create_table "meals_ingredients", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ingredient_id", null: false
    t.index ["ingredient_id"], name: "index_meals_ingredients_on_ingredient_id"
    t.index ["meal_id"], name: "index_meals_ingredients_on_meal_id"
  end

  create_table "order_ingredients", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_order_ingredients_on_ingredient_id"
    t.index ["order_id"], name: "index_order_ingredients_on_order_id"
  end

  create_table "order_meals", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "meal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meal_id"], name: "index_order_meals_on_meal_id"
    t.index ["order_id"], name: "index_order_meals_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "option_category"
    t.string "address"
    t.integer "budget"
    t.integer "number_of_meals"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.integer "amount_cents", default: 0, null: false
    t.integer "delivery_time"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "status"
    t.string "delivery_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "food_category_meals", "food_categories"
  add_foreign_key "food_category_meals", "meals"
  add_foreign_key "food_category_orders", "food_categories"
  add_foreign_key "food_category_orders", "orders"
  add_foreign_key "meals", "restaurants"
  add_foreign_key "meals_ingredients", "ingredients"
  add_foreign_key "meals_ingredients", "meals"
  add_foreign_key "order_ingredients", "ingredients"
  add_foreign_key "order_ingredients", "orders"
  add_foreign_key "order_meals", "meals"
  add_foreign_key "order_meals", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
end
