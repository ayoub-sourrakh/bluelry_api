# app/controllers/api/v1/payments_controller.rb
module Api
    module V1
      class PaymentsController < ApplicationController
        def create
          begin
            # Crée une session de paiement
            session = Stripe::Checkout::Session.create(
              payment_method_types: ['card'],
              line_items: [{
                name: 'Nom du produit',
                amount: (params[:amount].to_f * 100).to_i, # en cents
                currency: 'eur',
                quantity: 1,
              }],
              mode: 'payment',
              success_url: "#{root_url}/success?session_id={CHECKOUT_SESSION_ID}",
              cancel_url: "#{root_url}/cancel",
            )
  
            render json: { id: session.id }, status: :ok
          rescue Stripe::CardError => e
            render json: { error: e.message }, status: :unprocessable_entity
          end
        end
      end
    end
  end
  