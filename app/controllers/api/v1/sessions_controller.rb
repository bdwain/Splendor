module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      skip_before_filter :authenticate_entity_from_token!
      skip_before_filter :authenticate_entity!
      
      before_filter :authenticate_entity_from_token!, :only => [:destroy]
      before_filter :authenticate_entity!, :only => [:destroy]
     
      def create
        warden.authenticate!(:scope => resource_name)

        render json: {
          message: 'Logged in',
          auth_token: current_user.authentication_token
        }, status: HTTP_OK
      end
     
      def destroy
        if user_signed_in?
          current_user.authentication_token = nil
          current_user.save!

          message = "Logged out successfully"
          status = HTTP_OK
        else
          message = "Failed to log out. You need to be logged in to log out."
          status = HTTP_UNAUTHORIZED
        end

        render json: {
          message: message
        }, status: status
      end
    end
  end
end