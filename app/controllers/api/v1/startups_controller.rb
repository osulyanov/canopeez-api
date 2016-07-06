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
          param :logo, ActionDispatch::Http::UploadedFile, desc: 'Logo Image'
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
          # param :reference_ids, Array,
          #       desc: 'Reference IDs. For premium users only'
          param :founders_attributes, Array, desc: 'Array of founders' do
            param ':number', Array, desc: 'Serial number of founder, 0-999',
                                    required: true do
              param :name, String, desc: 'Name', required: true
              param :surname, String, desc: 'Surname', required: true
              param :position, String, desc: 'Position'
              param :description, String, desc: 'Description'
              param :quote, String, desc: 'Quote'
              param :linkedin_url, String, desc: 'Linkedin URL'
              param :photo_url, String, desc: 'Photo URL'
            end
          end
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
            "logo_url": "https://canopeez-development.s3.amazonaws.com/uploads/startup/logo/1/eye22n.jpeg",
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
            ],
            "reference_ids": [],
            "founder_ids": [
              17,
              16
            ]
          }
        ]
      EOS

      def index
        @startups = Startup.active
        respond_with :api, :v1, @startups
      end

      api :GET, '/v1/startups/search', 'Search by startups'
      description <<-EOS
        ## Description
        Search by startups.
      EOS
      param :keyword, String, desc: 'Search by keyword'
      param :startup_ids, Array, desc: 'Search by category ID'
      example <<-EOS
        [
          {
            "id": 1,
            "name": "Deals",
            "description": "Good app",
            "rating": 5
          }
        ]
      EOS

      def search
        @startups = Startup.active
        if params[:keyword].present?
          @startups = @startups.search_by_keyword(params[:keyword])
        end
        if params[:category_ids].present?
          @startups = @startups.search_by_category(params[:category_ids])
        end
        respond_with :api, :v1, @startups
      end

      api! 'Show startup'
      description <<-EOS
        ## Description
        Show startup by ID
      EOS
      example <<-EOS
        For owner:
        {
          "id": 1,
          "category_id": 1,
          "name": "Deals",
          "logo_url": "https://canopeez-development.s3.amazonaws.com/uploads/startup/logo/1/eye22n.jpeg",
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
          ],
          "reference_ids": [],
            "founder_ids": [
              17,
              16
            ]
        }

        For other users:
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
          "partner_ids": [
            1
          ],
          "reference_ids": [
            2,
            3,
            4
          ],
          "founder_ids": [
            4,
            3,
            2,
            1
          ],
          "favorite": true,
          "subscribed": true,
          "attachments": [
            {
              "text": "Awesome! ",
              "user": {
                "display_name": "Name4 Surname"
              }
            }
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
          "logo_url": "https://canopeez-development.s3.amazonaws.com/uploads/startup/logo/1/eye22n.jpeg",
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
          ],
          "reference_ids": [],
          "founder_ids": [
            17,
            16
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
              .permit(:category_id, :name, :logo, :description, :pitch,
                      :twitter_url, :facebook_url, :google_url, :linkedin_url,
                      :youtube_url, :instagram_url, :crowdfunding_url,
                      partner_ids: [], reference_ids: [],
                      founders_attributes: [[:id, :name, :surname, :position,
                                             :description, :quote,
                                             :linkedin_url, :photo_url]])
              .tap do |p|
          p.delete(:partner_ids) unless can? :have_partners, Startup
          p.delete(:reference_ids) unless can? :have_references, Startup
        end
      end

      def set_startup
        @startup = Startup.find_by(id: params[:id])
      end
    end
  end
end
