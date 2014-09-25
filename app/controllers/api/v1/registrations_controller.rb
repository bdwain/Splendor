module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json
     
      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      skip_before_filter :authenticate_entity_from_token!, only: [ :create ]
      skip_before_filter :authenticate_entity!, only: [ :create ]

      skip_before_filter :authenticate_scope!
      append_before_filter :authenticate_scope!, only: [ :destroy ]
     
      def create
        build_resource(sign_up_params)
        if resource.save
          status = HTTP_OK
          message = "Successfully created new account for email #{sign_up_params[:email]}."
        else
          clean_up_passwords resource
          status = HTTP_INTERNAL_SERVER_ERROR
          message = "Failed to create new account for email #{sign_up_params[:email]}."
        end

        render json: {
          message: message
        }, status: status
      end

      def destroy
        resource.destroy
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        
        render json: {
          message: 'Successfully deleted the account.'
        }, status: HTTP_OK
      end

      private

      def sign_up_params
        devise_parameter_sanitizer.sanitize(:sign_up)
      end
    end
  end
end