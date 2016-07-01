module Api
  module V1
    class RatingsController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_user, only: [:index]
      load_and_authorize_resource

      resource_description do
        short 'Ratings'
      end

      api :GET, '/v1/me/ratings', 'Ratings list'
      description <<-EOS
        ## Description
        List of ratings.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "startup_id": 1,
            "value": 5
          }
        ]
      EOS

      def index
        @ratings = @user.ratings
        respond_with :api, :v1, @ratings
      end

      private

      def set_user
        @user = if params[:me]
                  current_user
                else
                  User.find_by(id: params[:user_id])
                end
      end
    end
  end
end
