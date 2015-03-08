class ApplicationController < ActionController::API
  #these includes are needed because ActionController::API doesn't include things devise needs
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::Serialization
  include SimpleTokenAuthentication::ActsAsTokenAuthenticationHandler

  protected
  #seems like the cleanest way of ensuring a login until something similar gets put in the simple token authentication gem
  def require_authentication_of_entity!
    user_signed_in? || throw(:warden, scope: :"user")      
  end
end
