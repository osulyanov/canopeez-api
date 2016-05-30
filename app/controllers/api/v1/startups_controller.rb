module Api
  module V1
    class StartupsController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_startup, only: [:show, :update, :destroy]
      load_and_authorize_resource

      resource_description do
        short 'Startups'
      end

      def_param_group :startup do
        param :startup, Hash, desc: 'Startup info', required: true do
          param :name, String, desc: 'Name', required: true
          param :category_id, Integer, desc: 'Category', required: true
          param :logo_url, String, desc: 'Logo URL'
          param :description, String, desc: 'Description'
          param :pitch, String, desc: 'Pitch'
          param :twitter_url, String, desc: 'Twitter URL'
          param :facebook_url, String, desc: 'Facebook URL'
          param :google_url, String, desc: 'Google URL'
          param :linkedin_url, String, desc: 'Linkedin URL'
          param :youtube_url, String, desc: 'Youtube URL'
          param :instagram_url, String, desc: 'Instagram URL'
          param :crowdfunding_url, String, desc: 'Crowdfunding URL'
          param :partner_ids, Array, desc: 'Partner IDs. For premium users only'
        end
      end

      api :GET, '/v1/startups', 'Startups list'
      description <<-EOS
        ## Description
        List of all startups.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "category_id": 1,
            "name": "Deals",
            "logo_url": "",
            "description": "Good app",
            "pitch": "We are the best",
            "twitter_url": "",
            "facebook_url": "",
            "google_url": "",
            "linkedin_url": "",
            "youtube_url": "",
            "instagram_url": "",
            "crowdfunding_url": ""
          }
        ]
      EOS

      def index
        @startups = Startup.active
        respond_with :api, :v1, @startups
      end

      api! 'Show startup'
      description <<-EOS
        ## Description
        Show startup by ID
      EOS
      example <<-EOS
        {
          "id": 1,
          "category_id": 1,
          "name": "Deals",
          "logo_url": "",
          "description": "Good app",
          "pitch": "We are the best",
          "twitter_url": "",
          "facebook_url": "",
          "google_url": "",
          "linkedin_url": "",
          "youtube_url": "",
          "instagram_url": "",
          "crowdfunding_url": "",
          "crowdfunding_url": null,
          "partner_ids": [
            1,
            2
          ]
        }
      EOS

      def show
      end

      api! 'Create startup'
      description <<-EOS
        ## Description
        Creates startup.
        Returns code 201 and startup data if it successfully created.
      EOS
      param_group :startup
      example <<-EOS
        {
          "id": 1,
          "category_id": 1,
          "name": "Deals",
          "logo_url": "",
          "description": "Good app",
          "pitch": "We are the best",
          "twitter_url": "",
          "facebook_url": "",
          "google_url": "",
          "linkedin_url": "",
          "youtube_url": "",
          "instagram_url": "",
          "crowdfunding_url": "",
          "crowdfunding_url": null,
          "partner_ids": [
            1,
            2
          ]
        }
      EOS

      def create
        @startup = current_user.startups.create(startup_params)
        respond_with :api, :v1, @startup
      end

      api! 'Update startup'
      description <<-EOS
        ## Description
        Updates startup data.
        Returns code 204 if it successfully updated.
      EOS
      param_group :startup

      def update
        @startup.update_attributes(startup_params)
        respond_with :api, :v1, @startup
      end

      api! 'Destroy startup'
      description <<-EOS
        ## Description
        Destroys startup.
        Returns code 204 if it successfully destroyed.
      EOS

      def destroy
        @startup.destroy
        respond_with :api, :v1, @startup
      end

      private

      def startup_params
        params.require(:startup)
              .permit(:category_id, :name, :logo_url, :description, :pitch,
                      :twitter_url, :facebook_url, :google_url, :linkedin_url,
                      :youtube_url, :instagram_url, :crowdfunding_url,
                      partner_ids: [])
              .tap do |p|
          p.delete(:partner_ids) unless can? :have_partners, Startup
        end
      end

      def set_startup
        @startup = Startup.find_by(id: params[:id])
      end
    end
  end
end
