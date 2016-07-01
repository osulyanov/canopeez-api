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
end
