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

      api :POST, '/v1/comments', 'Comment startup'
      description <<-EOS
        ## Description
        Creates comment.
        Returns code 201 and comment data if it successfully created.
      EOS
      param :comment, Hash, desc: 'Comment info', required: true do
        param :startup_id, Integer, desc: 'Startup ID'
        param :comment, Integer, desc: 'Comment text'
      end
      example <<-EOS
        {
          "id": 3,
          "startup_id": 1,
          "comment": "Good",
          "created_at": "2016-07-04T16:56:03.924Z"
        }
      EOS

      def create
        @comment = current_user.comments.create(comment_params)
        respond_with :api, :v1, @comment
      end

      private

      def comment_params
        params.require(:comment).permit(:startup_id, :comment)
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
