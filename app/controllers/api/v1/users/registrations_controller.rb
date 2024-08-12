# app/controllers/api/v1/users/registrations_controller.rb
module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :verify_authenticity_token

        respond_to :json

        def create
          build_resource(sign_up_params)

          if resource.save
            render json: { status: 'success', user: resource }, status: :created
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
end
