Stripe.api_key = ENV['STRIPE_SECRET']

class Api::StripeController < ApplicationController
  def create_subscription
    source = params['source']
    planId = params['planId']
    seats = params['seats']

    user = current_user

    if(user.stripe_id)
      customer = Stripe::Customer.retrieve(user.stripe_id)
    end

    if !customer
      customer = Stripe::Customer.create({
        email: user.email,
        name: user.name,
        source: source['id'],
        metadata: {
          app_id: user.id
        }
      })

      user.stripe_id = customer.id
      user.save
    end

    # TODO: test what happens when it's called multiple times on one user
    # Desired behavior is to cancel the old subscription and create a new one

    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [{plan: planId, quantity: seats}]
    })

    user.subscription_id = subscription.id
    user.plan_id = planId
    user.plan_seats = seats.to_i
    user.plan_hash = subscription.plan.to_hash
    user.save

    render json: UserSerializer.new(user).serializable_hash
  end

  def user_info
    customer_id = current_user.stripe_id 
    if(!customer_id)
      head 400
    end

    if(current_user.subscription_id) then
      subscription = Stripe::Subscription.retrieve(current_user.subscription_id)
      card = Stripe::Customer.retrieve_source(customer_id, subscription.default_payment_method)
      card = card.data[0].card
    end
    charges = Stripe::Charge.list({customer: customer_id})
    
    
    render json: {
      charges: charges.data,
      card: card,
      subscription: subscription,
    }
  end

  def cancel_subscription
    user = current_user
    subscription = Stripe::Subscription.update(user.subscription_id, {cancel_at_period_end: true})
    user.subscription_cancelled = true
    user.save
    render json: subscription
  end


  def resubscribe
    user = current_user
    subscription = Stripe::Subscription.update(user.subscription_id, {cancel_at_period_end: false})
    user.subscription_cancelled = false
    user.save
    render json: subscription
  end

  def change_card
    response = Stripe::Customer.update(current_user.stripe_id, {
      source: params[:source][:id]
    })
    card = response.sources.data.first
    render json: card
  end
end