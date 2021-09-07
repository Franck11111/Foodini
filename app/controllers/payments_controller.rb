class PaymentsController < ApplicationController
  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @order = current_user.orders.where(status: 'pending').find(params[:order_id])
    @payment = Payment.new
  end

  def create
    @order = Order.find(params[:order_id])
    @payment = Payment.new(payment_params)
    @payment.order = @order
    if @payment.save
      @order.update(option_category: 'I am feeling lucky')
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:status, :delivery_address, :order_id)
  end
end
