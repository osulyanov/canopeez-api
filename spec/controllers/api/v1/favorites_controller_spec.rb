require 'rails_helper'

describe Api::V1::FavoritesController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let(:startup) { create :startup, user: user }
    let!(:favorite) { create :favorite, user: user, startup: startup }

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json, me: true
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns favorites as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(favorite.id)
    end
  end

  describe 'DELETE #destroy' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:favorite) { create :favorite, user: user, startup: startup }

    before do
      @request.headers.merge! token
      delete :destroy, format: :json, id: favorite.id
    end

    it { expect(response).to have_http_status(:success) }

    it 'destroys favorite' do
      result = Favorite.all

      expect(result).not_to include(favorite)
    end

    context 'other user cannot destroy favorite' do
      let(:user_2) { create :user }
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }

      it 'doesn\'t destroy the favorite' do
        favorite.reload

        result = favorite

        expect(result).to be_persisted
      end
    end
  end
end
