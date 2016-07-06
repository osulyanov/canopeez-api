module Api
  module V1
    class PartnersController < Api::V1::V1Controller
      before_action :authenticate_user!
      load_and_authorize_resource

      resource_description do
        short 'Partners'
      end

      api :GET, '/v1/partners', 'Partners list'
      description <<-EOS
        ## Description
        List of all partners sorted by name.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "name": "Yandex",
            "logo_url": "https://canopeez-development.s3.amazonaws.com/uploads/startup/logo/1/eye22n.jpeg",
          }
        ]
      EOS

      def index
        @partners = Partner.alphabet
        respond_with :api, :v1, @partners
      end
    end
  end
end
