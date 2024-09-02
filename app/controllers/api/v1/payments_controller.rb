module Api
    module V1
        class PaymentsController < ApplicationController
            before_action :authenticate_api_v1_user!
            
            def create_payment_intent
                # Log the incoming request parameters
                Rails.logger.info("Starting create_payment_intent action")
                Rails.logger.info("Received params: #{params.inspect}")
                
                amount = params[:amount]
                Rails.logger.info("Amount to process: #{amount}")
                
                if amount.nil?
                    Rails.logger.error("Amount is missing from the request")
                    render json: { error: "Amount is missing" }, status: :unprocessable_entity
                    return
                end
                
                begin
                    payment_intent = Stripe::PaymentIntent.create(
                    amount: amount,
                    currency: 'eur',
                    payment_method_types: ['card'],
                    metadata: {
                    user_id: current_api_v1_user.id, # Track the user who initiated the payment
                    email: current_api_v1_user.email # Log the user's email for additional context
                }
                )
                Rails.logger.info("PaymentIntent created successfully with ID: #{payment_intent.id}")
                
                render json: { client_secret: payment_intent.client_secret }, status: :ok
            rescue Stripe::StripeError => e
                Rails.logger.error("Stripe error occurred: #{e.message}")
                render json: { error: e.message }, status: :unprocessable_entity
            rescue => e
                Rails.logger.error("Unexpected error occurred: #{e.message}")
                render json: { error: "Something went wrong" }, status: :internal_server_error
            end
        end
    end
end
end
