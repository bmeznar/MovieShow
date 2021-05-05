class SubscribersController < ApplicationController

  before_action :authenticate_user!

  def new
    if user_signed_in? && current_user.subscribed?
      redirect_to root_path, notice: "You are already a subscriber"
    end
  end

  def create
    token=params[:stripeToken]
    customer=Stripe::Customer.create(
      card: token,
      plan: 'prod_JIKWwiwuJFfiJj',
      email: current_user.email
    )
    current_user.subscribed=true;
    current_user.stripeid=customer.id
    current_user.save
    redirect_to movies_path
  end
end