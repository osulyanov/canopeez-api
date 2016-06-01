require 'rails_helper'

describe Api::V1::ContactMessagesController, type: :controller do
  let(:user) { create :user }

  describe 'POST #create' do
    let(:token) { user.create_new_auth_token }
    let(:message_attributes) do
      attributes_for(:contact_message, message: 'New message')
    end

    before do
      @request.headers.merge! token
      post :create, format: :json, contact_message: message_attributes
    end

    context 'logged in user' do
      it { expect(response).to have_http_status(:success) }

      it 'creates message' do
        message = ContactMessage.last

        result = message.message

        expect(result).to eq('New message')
      end

      it 'sets user' do
        message = ContactMessage.last

        result = message.user_id

        expect(result).to eq(user.id)
      end
    end

    context 'guest user' do
      let(:token) { {} }

      it { expect(response).to have_http_status(:success) }

      it 'creates message' do
        message = ContactMessage.last

        result = message.message

        expect(result).to eq('New message')
      end

      it 'doesn\'t set user' do
        message = ContactMessage.last

        result = message.user_id

        expect(result).to be_nil
      end
    end
  end
end
