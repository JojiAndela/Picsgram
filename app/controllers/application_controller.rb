class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

protected
def configure_permitted_parameters
  added_attrs = [:username, :email, :password, :password_confirmation, :is_male, :dob, :phone, :address,:status,:firstname,:lastname,:avatar]
  devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  devise_parameter_sanitizer.permit :account_update, keys: added_attrs
end
end
