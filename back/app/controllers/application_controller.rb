class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false # APIではCSRFチェックをしない
  # before_action :configure_permitted_parameters, if: :devise_controller?	  # before_action :configure_permitted_parameters, if: :devise_controller?
  # protected	  # protected
  # def configure_permitted_parameters	  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password, :password_confirmation, :format, :session])	  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password, :password_confirmation, :format, :session])
  # end
end
