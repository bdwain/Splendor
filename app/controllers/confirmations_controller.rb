class ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      message = "You successfully confirmed your account."
      status = HTTP_OK
    else
      message = "Invalid confirmation code"
      status = HTTP_INTERNAL_SERVER_ERROR
    end

    render html: message, status: status
  end
end