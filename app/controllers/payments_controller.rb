class PaymentsController < ApplicationController
  def new
    @order = Order.all.where(state: 'pending').find(params[:order_id])
  end
end
