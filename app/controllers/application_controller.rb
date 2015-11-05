class ApplicationController < ActionController::Base
  ## Prevent CSRF attacks by raising an :exception.
  ## For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  
  
  
  ## Setup application responding
  respond_to :json
  
  
  
  
  ## Catch Exceptions
  # save!, create!, update!
  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end
  
  # destroy!
  rescue_from ActiveRecord::RecordNotDestroyed  do |exception|
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end
  
  # find, first!, last!
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: exception, status: :not_found
  end
  
  rescue_from CustomException::UnprocessableEntity do |exception|
    render nothing: true, status: :unprocessable_entity
  end
  
  rescue_from CustomException::Forbidden do |exception|
    render nothing: true, status: :forbidden
  end
  
  
  
  
  ## Always check for provided token authentication
  before_filter :authenticate_user_from_token
  def authenticate_user_from_token
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)
      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end
  
  
  
  
  ## Filter function to ensure the user is authenticated
  def authenticate_user!
    if current_user.blank?
      head status: :unauthorized
      return false
    end
  end
end
