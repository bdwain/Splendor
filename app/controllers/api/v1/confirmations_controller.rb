module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      respond_to :json
     
      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      skip_before_filter :authenticate_entity_from_token!, only: [ :create ]
      skip_before_filter :authenticate_entity!, only: [ :create ]
     
      skip_before_filter :authenticate_scope!
      append_before_filter :authenticate_scope!, only: [ :destroy ]
     
      def create
        resource_class.send_confirmation_instructions(resource_params)

        if successfully_sent?(resource)
          message = "successfully resent confirmation email"
          status = HTTP_OK
        else
          message = "failed to resend confirmation email"
          status = HTTP_INTERNAL_SERVER_ERROR
        end

        render json: {
          message: message
        }, status: status
      end
    end
  end
end