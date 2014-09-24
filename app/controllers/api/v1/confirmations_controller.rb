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
          render json: "success", status: 200
        else
          render json: "success", status: 500
        end
      end

      def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])

        if resource.errors.empty?
          render json: "success", status: 200
        else
          render json: resource.errors, status: 400
        end
      end
    end
  end
end