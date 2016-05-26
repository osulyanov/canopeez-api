require 'rails_helper'

describe Api::V1::StartupsController, type: :controller do
  let(:user) { create :user }
  let(:user_2) { create :user }

  describe 'GET #index' do
    let!(:startup_active) { create :startup, user: user }
    let!(:startup_inactive) { create :startup, user: user, is_active: false }
    let!(:startup_other) { create :startup, user: user_2 }

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns active startups as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(startup_active.id, startup_other.id)
    end
  end
end
