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

      api :GET, '/v1/me/favorites', 'Favorites list'
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

      api! 'Create favorite'
      description <<-EOS
        ## Description
        Add startup to favorites.
        Returns code 201 and favorite data if it successfully created.
      EOS
      param :favorite, Hash, desc: 'Favorite info',
                             required: true do
        param :startup_id, Integer, desc: 'Startup ID'
      end
      example <<-EOS
        {
          "id": 3,
          "startup_id": 1
        }
      EOS

      def create
        @favorite = current_user.favorites.create(favorite_params)
        respond_with :api, :v1, @favorite
      end

      api! 'Remove from favorites'
      description <<-EOS
        ## Description
        Remove favorite by ID.
        Returns code 204 if it successfully removed.
      EOS

      def destroy
        @favorite.destroy
        respond_with :api, :v1, @favorite
      end

      private

      def favorite_params
        params.require(:favorite).permit(:startup_id)
      end

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
