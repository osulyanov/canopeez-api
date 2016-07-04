module Api
  module V1
    class CommentsController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_user, only: [:index]
      load_and_authorize_resource

      resource_description do
        short 'Comments'
      end

      api :GET, '/v1/me/comments', 'Comments list'
      description <<-EOS
        ## Description
        List of comments.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "startup_id": 1,
            "comment": "Awesome! ",
            "created_at": "2016-07-01T10:37:23.758Z"
          }
        ]
      EOS

      def index
        @comments = @user.comments
        respond_with :api, :v1, @comments
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
