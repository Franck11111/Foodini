class OrdersController < ApplicationController
  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new
    @order_ingredient = OrderIngredient.new
    @food_category_order = FoodCategoryOrder.new
  end

  def create
    # @meal = Meal.find(params[:meal_id])
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'
    # @order.amount = @meal.price
    @order.save
    @order.meals_proposition
    meals_count = Hash.new(0)
    meals = []



    # session = Stripe::Checkout::Session.create(
    #   payment_method_types: ['card'],
    #   line_items: [{
    #     name: @meal.name,
    #     images: [@meal.photo_url],
    #     amount: @meal.price_cents,
    #     currency: 'eur',
    #     quantity: 1
    #   }],
    #   success_url: order_url(order),
    #   cancel_url: order_url(order)
    # )

    if @order.save
      # @order.update(checkout_session_id: session.id)
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
