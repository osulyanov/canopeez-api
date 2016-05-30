module Api
  module V1
    class FoundersController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_founder, only: [:show, :update, :destroy]
      before_action :set_startup, only: [:create]
      load_and_authorize_resource

      resource_description do
        short 'Founders'
      end

      def_param_group :founder do
        param :founder, Hash, desc: 'Founder info', required: true do
          param :name, String, desc: 'Name', required: true
          param :surname, String, desc: 'Surname', required: true
          param :position, String, desc: 'Position'
          param :description, String, desc: 'Description'
          param :quote, String, desc: 'Quote'
          param :linkedin_url, String, desc: 'Linkedin URL'
          param :photo_url, String, desc: 'Photo URL'
        end
      end

      api :GET, '/v1/founders', 'Founders list'
      description <<-EOS
        ## Description
        List of all founders created by current user.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "startup_id": 1,
            "name": "Vasiliy",
            "surname": "Terkin",
            "position": "SEO",
            "description": "1",
            "quote": "2",
            "linkedin_url": "3",
            "photo_url": "4"
          }
        ]
      EOS

      def index
        @founders = Founder.all
        respond_with :api, :v1, @founders
      end

      api! 'Show founder'
      description <<-EOS
        ## Description
        Show founder by ID
      EOS
      example <<-EOS
        {
          "id": 1,
          "startup_id": 1,
          "name": "Vasiliy",
          "surname": "Terkin",
          "position": "SEO",
          "description": "1",
          "quote": "2",
          "linkedin_url": "3",
          "photo_url": "4"
        }
      EOS

      def show
      end

      api :POST, '/v1/startups/:id/founders', 'Create founder'
      description <<-EOS
        ## Description
        Creates founder.
        Returns code 201 and founder data if it successfully created.
      EOS
      param_group :founder
      example <<-EOS
        {
          "id": 1,
          "startup_id": 1,
          "name": "Vasiliy",
          "surname": "Terkin",
          "position": "SEO",
          "description": "1",
          "quote": "2",
          "linkedin_url": "3",
          "photo_url": "4"
        }
      EOS

      def create
        @founder = @startup.founders.create(founder_params)
        respond_with :api, :v1, @founder
      end

      api! 'Update founder'
      description <<-EOS
        ## Description
        Updates founder's data.
        Returns code 204 if it successfully updated.
      EOS
      param_group :founder

      def update
        @founder.update_attributes(founder_params)
        respond_with :api, :v1, @founder
      end

      api! 'Destroy founder'
      description <<-EOS
        ## Description
        Destroys founder.
        Returns code 204 if it successfully destroyed.
      EOS

      def destroy
        @founder.destroy
        respond_with :api, :v1, @founder
      end

      private

      def founder_params
        params.require(:founder)
              .permit(:name, :surname, :position, :description, :quote,
                      :linkedin_url, :photo_url)
      end

      def set_founder
        @founder = Founder.find_by(id: params[:id])
      end

      def set_startup
        @startup = Startup.find_by(id: params[:id])
      end
    end
  end
end
