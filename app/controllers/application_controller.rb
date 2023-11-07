class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    wrap_parameters format: []

    before_action :set_current_user

    include ActionController::Cookies

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid


    def current_user
        Client.find_by(id: session[:user_id])
    end

    def set_current_user
        @current_user = current_user
    end

    def logged_in?
        !!current_user
    end

    def require_login
        unless logged_in?
            render json: { error: "You must be logged in to access this section" }, status: :unauthorized
        end
    end

      private
  
    def record_not_found
        render json: { error: "This record does not exist!" }, status: :not_found
    end

    def record_invalid
        render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end      
  
end
