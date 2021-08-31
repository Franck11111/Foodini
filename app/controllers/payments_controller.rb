class PaymentsController < ApplicationController

  def new
    @order = Order.find(params[:order_id])
    @payment = Payment.new
  end

  def create
    @order = Order.find(params[:order_id])
    @payment = Payment.new(payment_params)
    @payment.order = @order
    if @payment.save
      redirect_to order_path(@order), notice: 'Payment was successfully processed.'
    else
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:status, :delivery_address, :order_id)
  end
end
