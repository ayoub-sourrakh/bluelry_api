# app/controllers/api/v1/registrations_controller.rb
module Api
    module V1
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :verify_authenticity_token
  
        def create
          build_resource(sign_up_params)
  
          resource.save
          if resource.errors.any?
            Rails.logger.info("Validation errors: #{resource.errors.full_messages.join(', ')}")
          end
  
          yield resource if block_given?
          if resource.persisted?
            if resource.active_for_authentication?
              sign_up(resource_name, resource)
              render json: { status: 'success', user: resource }, status: :created
            else
              render json: { status: 'error', message: resource.inactive_message }, status: :unprocessable_entity
            end
          else
            render json: { status: 'error', errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
  