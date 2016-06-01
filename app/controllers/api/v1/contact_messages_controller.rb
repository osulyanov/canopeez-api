module Api
  module V1
    class ContactMessagesController < Api::V1::V1Controller
      before_action :authenticate_user!
      load_and_authorize_resource

      resource_description do
        short 'Contact messages'
      end

      api! 'Create contact message'
      description <<-EOS
        ## Description
        Creates contact message.
        Returns code 201 and contact message ID if it successfully created.
      EOS
      param :contact_message, Hash, desc: 'Contact message info',
                                    required: true do
        param :message, String, desc: 'Message'
        param :action, [:reach, :reference], desc: 'Action'
        param :mail, String, desc: 'Mail'
        param :city, String, desc: 'City'
        param :full_name, String, desc: 'Full Name'
        param :kind, [:company, :individual], desc: 'Kind'
      end
      example <<-EOS
        {
          "id": 3
        }
      EOS

      def create
        obj = user_signed_in? ? current_user.contact_messages : ContactMessage
        @contact_message = obj.create(contact_message_params)
        respond_with :api, :v1, @contact_message
      end

      private

      def contact_message_params
        params.require(:contact_message)
              .permit(:message, :action, :mail, :city, :full_name, :kind)
      end
    end
  end
end
