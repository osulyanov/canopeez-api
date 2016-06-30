module Api
  module V1
    class CredentialsController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_user

      resource_description do
        short 'Current user'
      end

      api :GET, '/v1/me', 'Show current user'
      description <<-EOS
        ## Description
        Show data of current user
      EOS
      example <<-EOS
        {
          "id": 2,
          "name": "Name4",
          "surname": "Surname",
          "school": "",
          "nickname": null,
          "image": null,
          "created_at": "2016-05-26T04:00:05.218Z",
          "is_premium": true,
          "provider": "email",
          "uid": "user@example.com",
          "email": "user@example.com"
        }
      EOS

      def show
      end

      private

      def user_params
        params.require(:user)
              .permit(:name, :surname, :password)
      end

      def set_user
        @user = current_user
      end
    end
  end
end
