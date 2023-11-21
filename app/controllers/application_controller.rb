class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  wrap_parameters format: []
  before_action :set_current_user

  include ActionController::Cookies

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def current_user
    @current_user
  end

  def set_current_user
    token = request.headers['Authorization']&.split&.last

    if token
      begin
        decoded_token = User.decode_jwt(token)
        @current_user ||= User.find_by(id: decoded_token['user_id'])
      rescue JWT::DecodeError
        # Handle JWT decode error, e.g., token is invalid
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      render json: { error: 'Unauthorized. User not logged in.' }, status: :unauthorized
      return
    end
  end
  

  private

  def record_not_found
    render json: { error: 'This record does not exist!' }, status: :not_found
  end

  def record_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
