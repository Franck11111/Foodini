class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user)
  end

  def show
    @order = current_user.orders.find(params[:id])
    # the `geocoded` scope filters only restaurants with coordinates (latitude & longitude)
    @restaurant_array = []
    @restaurants = @order.meals.each do |meal|
      element_restaurant = meal.restaurant
      @restaurant_array << element_restaurant.id
    end
    @restaurants_markers = Restaurant.where(id: @restaurant_array)
    @markers = @restaurants_markers.geocoded.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude,
          # to pass more info about our boardgames in our view
          info_window: render_to_string(partial: "info_window", locals: { restaurant: restaurant })
        }
    end
  end

  def new
    @order = Order.new
    @order_ingredient = OrderIngredient.new
    # filter all Food catogories contaning cuisine areas
    @cuisine_areas = FoodCategory.where.not(cuisine_area: nil)
    @cuisine_options = []
    @cuisine_area_to_categories = {}
    # iterate throu array of cuisine areas and store it in cuisin_ options to show in form
    @cuisine_areas.each do |cuisine_area|
      @cuisine_area_to_categories[cuisine_area.id] = cuisine_area.allowed_food_types.map(&:id)
      @cuisine_options << cuisine_area.cuisine_area
    end
    # filter all Food catogories contaning food types
    @food_types = FoodCategory.where.not(food_type: nil)
    @food_types_options = []
    # iterate throu array of food types and store it in food_type_options to show in form
    @food_types.each do |food_type|
      @food_types_options << food_type.food_type
    end
    @food_category_order = FoodCategoryOrder.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'
    # @order.amount = @meal.price
    # @meal = Meal.create!(name: "Pizza", description: "Pizza tomato and cheese", price: 15, restaurant_id: 1)
    if @order.save
      meals = @order.meals_proposition.first(@order.number_of_meals).map{|array| array.first}
      @order.meals << meals
      meal_price = 0
      @order.meals.each do |meal|
        meal_price += meal.price
      end
      @order.amount = meal_price
      @order.save
      if params[:order][:option_category] == "I am feeling cautious"
        redirect_to order_path(@order)
      else
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          line_items: [{
            name: "Option chosen: #{@order.option_category}",
            description: "Number of meals: #{@order.number_of_meals}",
            amount: @order.amount_cents,
            currency: 'eur',
            quantity: 1
          }],
          success_url: order_url(@order),
          cancel_url: order_url(@order)
        )
      end

      @order.update(checkout_session_id: session.id)
      if @order.option_category == 'I am feeling lucky'
        redirect_to new_order_payment_path(@order)
      else
        redirect_to order_path(@order)
      end
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:option_category, :delivery_time, :budget, :number_of_meals, :address, :user_id, food_category_ids: [], order_ingredients_attributes: [:order_id, :ingredient_id], order_meals_attributes: [:order_id, :meal_id])
  end
end
