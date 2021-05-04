class SubscribersController < ApplicationController

  before_action :authenticate_user!

  def new
    redirect_to 'subscribers#update'
  end

  def update
    token=params[:stripeToken]
    customer=Stripe::Customer.create(
      card: token,
      plan: 'prod_JIKWwiwuJFfiJj',
      email: current_user.email
    )
    current_user.subscribed=true;
    current_user.stripeid=customer.id
    current_user.save
    redirect_to 'movies#index'
  end

end
