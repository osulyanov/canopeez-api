module Api
  module V1
    class FavoritesController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_user, only: [:index]
      before_action :set_favorite, only: [:destroy]
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

      api! 'Remove from favorites'
      description <<-EOS
        ## Description
        Remove from favorites by favorite ID (not startup ID).
        Returns code 204 if it successfully removed.
      EOS

      def destroy
        @favorite.destroy
        respond_with :api, :v1, @favorite
      end

      private

      def set_user
        @user = if params[:me]
                  current_user
                else
                  User.find_by(id: params[:user_id])
                end
      end

      def set_favorite
        @favorite = Favorite.find_by(id: params[:id])
      end
    end
  end
end
