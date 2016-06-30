module Api
  module V1
    class FavoritesController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_user, only: [:index]
      load_and_authorize_resource

      resource_description do
        short 'Favorites'
      end

      api :GET, '/v1/me/founders', 'Favorites list'
      description <<-EOS
        ## Description
        List of favorites.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "startup_id": 1
          }
        ]
      EOS

      def index
        @favorites = @user.favorites
        respond_with :api, :v1, @favorites
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
