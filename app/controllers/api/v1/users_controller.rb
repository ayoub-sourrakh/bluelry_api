# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
    respond_to :json
    
    before_action :authenticate_api_v1_user!
    before_action :set_user, only: [:show]
    
    # GET /api/v1/users
    def index
        @users = User.all
        render json: @users
    end
    
    # GET /api/v1/users/:id
    def show
        render json: @user
    end
    
    def me
        render json: {
        status: 'success',
        user: @current_user,
        jwt_payload: @jwt_payload
        }
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
    end
end