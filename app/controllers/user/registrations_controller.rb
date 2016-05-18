class User::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  respond_to :json

  # POST /resource
  def create
    super
  end

  # PUT /resource
  def update
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname])
  end
end
