module Api
  module V1
    class UsersController < Api::V1::V1Controller
      resource_description do
        short 'Users'
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
    end
  end
end
