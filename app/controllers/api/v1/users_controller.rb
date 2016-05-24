module Api
  module V1
    class UsersController < Api::V1::V1Controller
      resource_description do
        short 'Users'
        description 'Based on [devise_token_auth gem](https://github.com/lynndylanhurley/devise_token_auth)'
      end

      def_param_group :user do
        param :email, String, desc: 'Email'
        param :password, String, desc: 'Password', required: true
        param :password_confirmation, String, desc: 'Password confirmation',
                                              required: true
        param :name, String, desc: 'Name'
        param :surname, String, desc: 'Surname'
      end

      api :POST, '/v1/users/sign_in', 'Sign In'
      description <<-EOS
        ## Description
        Sign in user. Returns user data and auth headers.
      EOS
      param :email, String, desc: 'Email', required: true
      param :password, String, desc: 'Password', required: true
      example <<-EOS
        {
          "data": {
            "id": 1,
            "provider": "email",
            "uid": "admin@example.com",
            "name": "Name",
            "surname": "Surname",
            "school": "SchoolName",
            "nickname": null,
            "image": null,
            "email": "admin@example.com",
            "role": "admin",
            "is_premium": false
          }
        }

        Headers:
        Access-Token → cDnvA43Hyuzz9C77TLRVVg
        Client → Amp1CsKxmZLcvHWU2hOxjg
        Expiry → 1465209257
        Token-Type → Bearer
        Uid → admin@example.com
      EOS

      def sign_in
      end

      api :POST, '/v1/users', 'Sign Up'
      description <<-EOS
        ## Description
        Sign up user. Return user data and auth headers if all data is valid,
        otherwise returns errors.
      EOS
      param_group :user
      example <<-EOS
        Success:
        {
          "status": "success",
          "data": {
            "id": 5,
            "provider": "email",
            "uid": "em10@il.ru",
            "name": "Name",
            "surname": "Surname",
            "school": null,
            "nickname": null,
            "image": null,
            "email": "em10@il.ru",
            "role": "user",
            "is_premium": false,
            "created_at": "2016-05-23T11:05:56.612Z",
            "updated_at": "2016-05-23T11:05:56.688Z"
          }
        }

        Headers:
        Access-Token → 8NG7aliy-A5huQQR0sqgJQ
        Client → GhqxzwmVSOpkjW-2W18JWA
        Expiry → 1465211156
        Uid → em10@il.ru

        Error:
        {
          "status": "error",
          "data": {
            "id": null,
            "provider": "email",
            "uid": "",
            "name": "Name",
            "surname": "Surname",
            "school": null,
            "nickname": null,
            "image": null,
            "email": "em10@il.ru",
            "role": "user",
            "is_premium": false,
            "created_at": null,
            "updated_at": null
          },
          "errors": {
            "email": [
              "already in use"
            ],
            "full_messages": [
              "Email already in use"
            ]
          }
        }
      EOS

      def sign_up
      end

      api :PUT, '/v1/users', 'Update account'
      description <<-EOS
        ## Description
        Updates users data. Return user data and auth headers if all data is valid,
        otherwise returns errors.
      EOS
      param_group :user
      example <<-EOS
        Success:
        {
          "status": "success",
          "data": {
            "id": 1,
            "provider": "email",
            "uid": "admin@example.com",
            "name": "Name4",
            "surname": null,
            "school": null,
            "nickname": null,
            "image": null,
            "email": "admin@example.com",
            "role": "admin",
            "is_premium": false,
            "created_at": "2016-05-20T09:58:24.366Z",
            "updated_at": "2016-05-23T11:32:27.335Z"
          }
        }

        Auth error:
        {
          "status": "error",
          "errors": [
            "User not found."
          ]
        }
      EOS

      def update
      end

      api :DELETE, '/v1/users/sign_out', 'Sign Out'
      description <<-EOS
        ## Description
        Destroys auth token.
      EOS
      param_group :user
      example <<-EOS
        Success:
        {
          "success": true
        }

        Auth error:
        {
          "errors": [
            "User was not found or was not logged in."
          ]
        }
      EOS
      def sign_out
      end

      api :GET, '/v1/users/:provider', 'Destination for client authentication'
      description <<-EOS
        ## Description
        Set this route as the destination for client authentication.
        Ideally this will happen in an external window or popup.
      EOS
      def oauth_destination
      end

      api :GET, '/v1/users/:provider/callback',
          'Destination for the oauth2 provider\'s callback uri'
      description <<-EOS
        ## Description
        Destination for the oauth2 provider's callback uri. postMessage events
        containing the authenticated user's data will be sent back to the main
        client window from this page.
      EOS
      def oauth_callback
      end

      api :GET, '/v1/users/validate_token', 'Validate token'
      description <<-EOS
        ## Description
        Use this route to validate tokens on return visits to the client.
        Requires uid, client, and access-token as params. These values should
        correspond to the columns in your User table of the same names.
      EOS
      def validate_token
      end
    end
  end
end
