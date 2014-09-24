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
        ActiveRecord::Base.transaction do

            build_resource(user_params)
            if resource.save
              render json: "success", status: 200
            else
              clean_up_passwords resource
              render json: resource.errors.as_json, status: 400
            end

        end
      end
     
      def destroy
        resource.destroy
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        render json: "success"
      end
     
      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :displayname)
      end
    end
  end
end