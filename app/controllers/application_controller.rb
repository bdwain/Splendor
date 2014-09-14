class ApplicationController < ActionController::API
  #protect_from_forgery

  #these includes are needed because ActionController::API doesn't include things devise needs
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :displayname
    devise_parameter_sanitizer.for(:account_update) << :displayname
  end
end
