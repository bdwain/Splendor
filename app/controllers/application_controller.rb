class ApplicationController < ActionController::API
  #these includes are needed because ActionController::API doesn't include things devise needs
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include SimpleTokenAuthentication::ActsAsTokenAuthenticationHandler

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :displayname
    devise_parameter_sanitizer.for(:account_update) << :displayname
  end

  #seems like the cleanest way of ensuring a login until something similar gets put in the simple token authentication gem
  def require_authentication_of_entity!
    user_signed_in? || throw(:warden, scope: :"user")      
  end
end
