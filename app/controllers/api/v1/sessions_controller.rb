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
        @user = current_user
      end
     
      def destroy
        if user_signed_in?
          @user = current_user
          @user.authentication_token = nil
          @user.save
        else
          render 'failure'
        end
      end
    end
  end
end