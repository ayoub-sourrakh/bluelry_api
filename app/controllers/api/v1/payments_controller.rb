module Api
    module V1
      class PaymentsController < ApplicationController
        def create_payment_intent
          amount = params[:amount] # Assurez-vous que ce paramètre est bien reçu
  
          if amount.nil?
            render json: { error: "Amount is missing" }, status: :unprocessable_entity
            return
          end
  
          begin
            payment_intent = Stripe::PaymentIntent.create(
              amount: amount,
              currency: 'eur',
              payment_method_types: ['card'],
            )
  
            render json: { client_secret: payment_intent.client_secret }, status: :ok
          rescue Stripe::StripeError => e
            render json: { error: e.message }, status: :unprocessable_entity
          end
        end
      end
    end
  end
  