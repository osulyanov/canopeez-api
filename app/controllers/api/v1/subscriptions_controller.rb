module Api
  module V1
    class SubscriptionsController < Api::V1::V1Controller
      before_action :authenticate_user!
      before_action :set_user, only: [:index]
      before_action :set_subscription, only: [:destroy]
      load_and_authorize_resource

      resource_description do
        short 'Subscriptions'
      end

      api :GET, '/v1/me/subscriptions', 'Subscriptions list'
      description <<-EOS
        ## Description
        List of subscriptions.
      EOS
      example <<-EOS
        [
          {
            "id": 1,
            "startup_id": 1
          }
        ]
      EOS

      def index
        @subscriptions = @user.subscriptions
        respond_with :api, :v1, @subscriptions
      end

      api! 'Create subscription'
      description <<-EOS
        ## Description
        Subscribe to startup.
        Returns code 201 and subscription ID if it successfully created.
      EOS
      param :subscription, Hash, desc: 'Subscription info',
                                 required: true do
        param :startup_id, Integer, desc: 'Startup ID'
      end
      example <<-EOS
        {
          "id": 3
        }
      EOS

      def create
        @subscription = current_user.subscriptions.create(subscription_params)
        respond_with :api, :v1, @subscription
      end

      api! 'Remove from subscriptions'
      description <<-EOS
        ## Description
        Remove subscription by ID.
        Returns code 204 if it successfully removed.
      EOS

      def destroy
        @subscription.destroy
        respond_with :api, :v1, @subscription
      end

      private

      def subscription_params
        params.require(:subscription).permit(:startup_id)
      end

      def set_user
        @user = if params[:me]
                  current_user
                else
                  User.find_by(id: params[:user_id])
                end
      end

      def set_subscription
        @subscription = Subscription.find_by(id: params[:id])
      end
    end
  end
end
