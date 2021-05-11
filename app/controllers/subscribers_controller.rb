class SubscribersController < ApplicationController

  before_action :authenticate_user!
  require "stripe"
  
  def show
  end

  def new
    if user_signed_in? && current_user.subscribed?
      redirect_to root_path, notice: "You are already a subscriber!"
    end
  end

  def update
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

    plan_id = 'prod_JIKWwiwuJFfiJj'
    token = params[:stripeToken]

    customer = if current_user.stripeid?
                Stripe::Customer.retrieve(current_user.stripeid)
               else
                Stripe::Customer.create(email: current_user.email, source: token)
              end

    subscription = customer.subscriptions.create(plan: plan.id)

    options = {
      stripeid: customer.id,
      subscribed: true
    }

    options.merge!(
      card_last4: params[:user][:card_last4],
      card_exp_month: params[:user][:card_exp_month],
      card_exp_year: params[:user][:card_exp_year],
      card_type: params[:user][:card_type]
    ) if params[:user][:card_last4]

    current_user.update(options)

    redirect_to root_path, notice: "Your subscription was setup successfully!"
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripeid: nil, subscribed: nil)

    redirect_to root_path, notice: "Your subscription has been canceled."
  end

  private

    def redirect_to_signup
      if !user_signed_in?
        session["user_return_to"] = new_subscription_path
        redirect_to new_user_registration_path
      end
    end

end
