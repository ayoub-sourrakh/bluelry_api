# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
    def create_payment_intent
      amount = params[:amount]
  
      begin
        payment_intent = Stripe::PaymentIntent.create(
          amount: amount,
          currency: 'eur', # Set your currency
          payment_method_types: ['card'],
        )
  
        render json: { client_secret: payment_intent.client_secret }, status: :ok
      rescue Stripe::StripeError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
  