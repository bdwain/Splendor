class AuthenticatedController < ApplicationController
  respond_to :json
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  append_before_filter :require_authentication_of_entity!
end
