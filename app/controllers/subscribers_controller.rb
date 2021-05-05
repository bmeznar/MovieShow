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

  #def new
  #  if user_signed_in? && current_user.subscribed?
  #    redirect_to root_path, notice: "You are already a subscriber"
  #  end
  #end

  #def create
  #  Stripe.api_key = Rails.application.credentials.stripe_api_key
  #  token=params[:stripeToken]

  #  plan_id = 'prod_JIKWwiwuJFfiJj'
  #  token = token

  #  customer = if current_user.stripe_id?
  #              Stripe::Customer.retrieve(current_user.stripeid)
  #             else
  #              Stripe::Customer.create(email: current_user.email, source: token)
  #            end

  #  subscription = customer.subscriptions.create(plan: plan.id)

  #  options = {
  #    stripeid: subscription.id,
  #    subscribed: true
  #  }

  #  options.merge!(
  #    card_last4: params[:user][:card_last4],
  #    card_exp_month: params[:user][:card_exp_month],
  #    card_exp_year: params[:user][:card_exp_year],
  #    card_type: params[:user][:card_type]
  #  ) if params[:user][:card_last4]

  #  current_user.update(options)

  #  redirect_to root_path, notice: "Your subscription was setup successfully!"
  #end

  #def destroy
  #  customer = Stripe::Customer.retrieve(current_user.stripe_id)
  #  customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
  #  current_user.update(stripe_subscription_id: nil)
  #  current_user.subscribed = false

  #  redirect_to root_path, notice: "Your subscription has been cancelled."
  #end

end
