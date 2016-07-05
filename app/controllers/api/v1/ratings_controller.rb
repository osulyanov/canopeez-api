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
            "id": 2,
            "value": 3,
            "created_at": "2016-07-04T16:25:43.838Z",
            "startup": {
              "id": 1,
              "name": "Deals"
            }
          }
        ]
      EOS

      def index
        @ratings = @user.ratings
        respond_with :api, :v1, @ratings
      end

      api :POST, '/v1/ratings', 'Rate startup'
      description <<-EOS
        ## Description
        Creates rating.
        Returns code 201 and rating data if it successfully created.
      EOS
      param :rating, Hash, desc: 'Rating info', required: true do
        param :startup_id, Integer, desc: 'Startup ID'
        param :value, Integer, desc: 'Rating value, 1-5'
      end
      example <<-EOS
        {
          "id": 2,
          "value": 3,
          "created_at": "2016-07-04T16:25:43.838Z",
          "startup": {
            "id": 1,
            "name": "Deals"
          }
        }
      EOS

      def create
        @rating = current_user.ratings.create(rating_params)
        respond_with :api, :v1, @rating
      end

      private

      def rating_params
        params.require(:rating).permit(:startup_id, :value)
      end

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
