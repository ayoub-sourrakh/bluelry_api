class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  def create
    Rails.logger.info("Params received: #{params.inspect}")
  
    # Prendre uniquement les paramètres sous "user"
    user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    
    # Construire la ressource utilisateur avec ces paramètres
    build_resource(user_params)
  
    if resource.save
      render json: { status: 'success', user: resource }, status: :created
    else
      Rails.logger.info("Validation errors: #{resource.errors.full_messages.join(', ')}")
      render json: { status: 'error', errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
