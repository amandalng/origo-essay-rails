class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show]

  def create
    @essay = Essay.find(params[:essay_id])
    @order = Order.create!(essay: @essay, amount: @essay.price, state: 'pending')

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        essay: @essay.student_name,
        # applicant_type: @order.essay.applicant_type,
        # prompt: @order.essay.prompt,
        # word_count: @order.essay.word_count,
        amount: @essay.price_cents,
        currency: 'USD',
        quantity: 1
      }],
      success_url: essay_order_url(@essay, @order),
      cancel_url: essay_order_url(@essay, @order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_essay_order_payment(@essay, @order)
  end

  def show
    @order = Order.find(params[:id])
  end
end
