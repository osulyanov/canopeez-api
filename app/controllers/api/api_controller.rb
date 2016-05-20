module Api
  class ApiController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken

    respond_to :json

    rescue_from CanCan::AccessDenied, with: :access_denied

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def access_denied(exception)
      message = exception.message || 'Access Denied'
      render json: { message: message }, status: 401
    end

    def not_found(exception)
      message = exception.message || 'Not found'
      render json: { message: message }, status: 404
    end
  end
end
