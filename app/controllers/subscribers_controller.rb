class SubscribersController < ApplicationController

  before_action :authenticate_user!

  def show
  end

  def new
  end

  def test
    customer = if current_user.stripeid?
                 Stripe::Customer.retrieve(current_user.stripeid)
               else
                 Stripe::Customer.create(email: current_user.email)
               end

    subscription = customer.subscriptions.create(
      source: params[:stripeToken],
      plan: "Monthly"
    )

    options = {
      stripeid: subscription.id,
      subscription: true,
    }

    # Only update the card on file if we're adding a new one
    options.merge!(
      card_last4: params[:card_last4],
      card_exp_month: params[:card_exp_month],
      card_exp_year: params[:card_exp_year],
      card_type: params[:card_brand]
    ) if params[:card_last4]

    current_user.update(options)

    redirect_to root_path
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