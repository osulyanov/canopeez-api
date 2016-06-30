require 'rails_helper'

describe Api::V1::CredentialsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create :user }
    let(:token) { user.create_new_auth_token }

    before do
      @request.headers.merge! token
      get :show, format: :json, me: true
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns current user as json' do
      expect(json['id']).to eq(user.id)
    end

    context 'without token' do
      let(:token) { {} }

      it { expect(response).to have_http_status(:unauthorized) }

      it { expect(json['errors']).to be_present }
    end
  end
end
