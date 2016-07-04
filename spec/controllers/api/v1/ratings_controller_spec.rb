require 'rails_helper'

describe Api::V1::RatingsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let(:startup) { create :startup, user: user }
    let!(:rating) { create :rating, user: user, startup: startup }

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json, me: true
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns ratings as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(rating.id)
    end
  end

  describe 'POST #create' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:rating_attributes) { { startup_id: startup.id, value: 3 } }

    before do
      @request.headers.merge! token
      post :create, format: :json, rating: rating_attributes
    end

    context 'logged in user' do
      it { expect(response).to have_http_status(:success) }

      it 'creates rating' do
        rating = user.ratings.last

        result = rating.startup_id

        expect(result).to eq(startup.id)
      end
    end

    context 'guest user' do
      let(:token) { {} }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
