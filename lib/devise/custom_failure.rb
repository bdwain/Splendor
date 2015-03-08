class CustomFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'json'
    self.response_body = {message: i18n_message}.to_json
  end
end