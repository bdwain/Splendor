module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json
     
      acts_as_token_authentication_handler_for User, fallback_to_devise: false, only: [:destroy]

      skip_before_filter :authenticate_scope! #devise made this and it's not necessary
      append_before_filter :require_authentication_of_entity!, only: [:destroy]
     
      def create
        build_resource(sign_up_params)
        begin
          resource.save!
          status = HTTP_OK
          message = "Successfully created new account for email #{sign_up_params[:email]}."
        rescue => e
          clean_up_passwords resource
          status = HTTP_FORBIDDEN
          message = e.message
          message.slice!("Validation failed: ")
        end

        render json: {
          message: message
        }, status: status
      end

      def destroy
        current_user.destroy
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