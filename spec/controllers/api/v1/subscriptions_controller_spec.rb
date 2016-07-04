require 'rails_helper'

describe Api::V1::SubscriptionsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let(:startup) { create :startup, user: user }
    let!(:subscription) { create :subscription, user: user, startup: startup }

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json, me: true
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns subscriptions as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(subscription.id)
    end
  end

  describe 'POST #create' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:subscription_attributes) { { startup_id: startup.id } }

    before do
      @request.headers.merge! token
      post :create, format: :json, subscription: subscription_attributes
    end

    context 'logged in user' do
      it { expect(response).to have_http_status(:success) }

      it 'creates subscription' do
        subscription = user.subscriptions.last

        result = subscription.startup_id

        expect(result).to eq(startup.id)
      end
    end

    context 'guest user' do
      let(:token) { {} }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'DELETE #destroy' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:subscription) { create :subscription, user: user, startup: startup }

    before do
      @request.headers.merge! token
      delete :destroy, format: :json, id: subscription.id
    end

    it { expect(response).to have_http_status(:success) }

    it 'destroys subscription' do
      result = Subscription.all

      expect(result).not_to include(subscription)
    end

    context 'other user cannot destroy subscription' do
      let(:user_2) { create :user }
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }

      it 'doesn\'t destroy the subscription' do
        subscription.reload

        result = subscription

        expect(result).to be_persisted
      end
    end
  end
end
