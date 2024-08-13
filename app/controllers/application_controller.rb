class ApplicationController < ActionController::API
  before_action :authenticate_api_v1_user!
  before_action :set_current_user_info
  before_action :ensure_json_request

  private

  def ensure_json_request
    request.format = :json
  end

  def set_current_user_info
    authorization_header = request.headers['Authorization']
    if authorization_header.present?
      token = authorization_header.split(' ').last
      begin
        @jwt_payload = Warden::JWTAuth::UserDecoder.new.call(token, :api_v1_user, nil)
        @current_user = User.find(@jwt_payload['id'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
        Rails.logger.info "JWT Decode Error: #{e.message}"
        @current_user = nil
        @jwt_payload = nil
      rescue Warden::JWTAuth::Errors::InvalidScope => e
        Rails.logger.info "JWT Scope Error: #{e.message}"
        @current_user = nil
        @jwt_payload = nil
      end
    else
      @current_user = nil
      @jwt_payload = nil
    end
  end

end
