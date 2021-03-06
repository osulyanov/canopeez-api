module Api
  module V1
    class CategoriesController < Api::V1::V1Controller
      load_and_authorize_resource

      resource_description do
        short 'Categories'
      end

      api :GET, '/v1/categories', 'Categories list'
      description <<-EOS
        ## Description
        List of all categories sorted by name.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "name": "Toys",
            "description": "%)\r\n"
          }
        ]
      EOS

      def index
        @categories = Category.alphabet
        respond_with :api, :v1, @categories
      end
    end
  end
end
