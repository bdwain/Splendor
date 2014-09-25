module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json

      acts_as_token_authentication_handler_for User, fallback_to_devise: false, only: [:destroy]
      append_before_filter :require_authentication_of_entity!, only: [:destroy]
      
      #this is necessary because the user is never "signed in", they just send the token for every request
      skip_before_filter :verify_signed_out_user, :only => :destroy

      def create
        self.resource = warden.authenticate!(:scope => resource_name)

        render json: {
          message: 'Logged in',
          auth_token: current_user.authentication_token
        }, status: HTTP_OK
      end
     
      def destroy
        current_user.authentication_token = nil
        current_user.save!

        message = "Logged out successfully"
        status = HTTP_OK

        render json: {
          message: message
        }, status: status
      end
    end
  end
end