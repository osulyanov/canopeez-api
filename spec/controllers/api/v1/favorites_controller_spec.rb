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
end
