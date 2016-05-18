class User::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  respond_to :json

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end
end
