class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order_ingredient = OrderIngredient.new
    @food_category_order = FoodCategoryOrder.new
  end

  def create
    @order = Order.new(order_params)
    # @order.order_meal = @order_meal
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_option_category, :delivery_time, :budget, :number_of_meals, :address, :user_id)
  end
end
