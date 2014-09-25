module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      respond_to :json
     
      def create
        self.resource = resource_class.send_confirmation_instructions(resource_params)

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