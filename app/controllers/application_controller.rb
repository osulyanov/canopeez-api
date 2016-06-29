class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :null_session,
  #                      if: proc { |c| c.request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
    devise_parameter_sanitizer
      .permit(:account_update, keys: [:name, :surname, :school])
  end

  def access_denied(exception)
    redirect_to current_user ? root_path : '/admin/login',
                alert: exception.message
  end
end
