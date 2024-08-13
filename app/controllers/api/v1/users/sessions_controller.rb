module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        def create
          user = User.find_for_database_authentication(email: params[:user][:email])

          Rails.logger.info user.first_name 
          
          if user&.valid_password?(params[:user][:password])
            sign_in(user)
            render json: { status: 'success', user: user }, status: :ok
          else
            render json: { status: 'error', message: 'Invalid email or password' }, status: :unauthorized
          end
        end

        def session_info
          exp = @jwt_payload['exp']
          session_time_left = Time.at(exp) - Time.now
        
          render json: {
            user: @current_user,
            session_time_left: session_time_left,
            jwt_payload: @jwt_payload
          }
        end

        private

        def respond_to_on_destroy
          render json: { status: 'success' }
        end

        def respond_with(resource, _opts = {})
          token = Warden::JWTAuth::UserEncoder.new.call(resource, :api_v1_user, nil)
          render json: { 
            status: 'success', 
            user: resource, 
            token: token.first 
          }
        end
      end
    end
  end
end
