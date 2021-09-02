class OrdersController < ApplicationController
  def show
    @order = current_user.orders.find(params[:id])
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

    @meal = Meal.create!(name: "Pizza", description: "Pizza tomato and cheese", price: 15, restaurant_id: 1)
    if @order.save
      @order.meals << @meal
      # @order.meals_proposition
      # meals_count = Hash.new(0)
      # meals = []

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @meal.name,
          description: @meal.description,
          amount: @meal.price_cents,
          currency: 'eur',
          quantity: 1
        }],
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      )

      @order.update(checkout_session_id: session.id, amount: @meal.price_cents*0.01)
      redirect_to new_order_payment_path(@order), notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_option_category, :delivery_time, :budget, :number_of_meals, :address, :user_id, order_ingredients_attributes: [:order_id, :ingredient_id], order_meals_attributes: [:order_id, :meal_id])
  end
end
