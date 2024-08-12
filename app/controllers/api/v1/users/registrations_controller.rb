class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  def create
    user_params = sign_up_params

    build_resource(user_params)

    if resource.save
      render json: { status: 'success', user: resource }, status: :created
    else
      Rails.logger.info("Validation errors: #{resource.errors.full_messages.join(', ')}")
      render json: { status: 'error', errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth)
  end
end
