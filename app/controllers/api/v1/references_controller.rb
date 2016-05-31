module Api
  module V1
    class ReferencesController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_reference, only: [:show, :update, :destroy]
      before_action :set_startup, only: [:create]
      load_and_authorize_resource

      resource_description do
        short 'References'
      end

      def_param_group :reference do
        param :reference, Hash, desc: 'Reference info', required: true do
          param :url, String, desc: 'URL', required: true
          param :description, String, desc: 'description', required: true
        end
      end

      api :GET, '/v1/references', 'References list'
      description <<-EOS
        ## Description
        List of all references created by current user.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "startup_id": 26,
            "url": "http://ya.ru",
            "description": "Yandex"
          }
        ]
      EOS

      def index
        @references = Reference.all
        respond_with :api, :v1, @references
      end

      api! 'Show reference'
      description <<-EOS
        ## Description
        Show reference by ID
      EOS
      example <<-EOS
        {
          "id": 1,
          "startup_id": 26,
          "url": "http://ya.ru",
          "description": "Yandex"
        }
      EOS

      def show
      end

      api :POST, '/v1/startups/:id/references', 'Create reference'
      description <<-EOS
        ## Description
        Creates reference.
        Returns code 201 and reference data if it successfully created.
      EOS
      param_group :reference
      example <<-EOS
        {
          "id": 2,
          "startup_id": 1,
          "url": "http://ya.ru",
          "description": "Ya.ru"
        }
      EOS

      def create
        authorize! :update, @startup
        @reference = @startup.references.create(reference_params)
        respond_with :api, :v1, @reference
      end

      api! 'Update reference'
      description <<-EOS
        ## Description
        Updates reference's data.
        Returns code 204 if it successfully updated.
      EOS
      param_group :reference

      def update
        @reference.update_attributes(reference_params)
        respond_with :api, :v1, @reference
      end

      api! 'Destroy reference'
      description <<-EOS
        ## Description
        Destroys reference.
        Returns code 204 if it successfully destroyed.
      EOS

      def destroy
        @reference.destroy
        respond_with :api, :v1, @reference
      end

      private

      def reference_params
        params.require(:reference).permit(:url, :description)
      end

      def set_reference
        @reference = Reference.find_by(id: params[:id])
      end

      def set_startup
        @startup = Startup.find_by(id: params[:id])
      end
    end
  end
end
