require 'rails_helper'

describe Api::V1::FoundersController, type: :controller do
  let(:user) { create :user }
  let(:user_2) { create :user }

  describe 'GET #index' do
    let(:startup) { create :startup, user: user }
    let!(:founder) { create :founder, startup: startup }

    before do
      @request.headers.merge! user_2.create_new_auth_token
      get :index, format: :json
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns founders as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(founder.id)
    end
  end

  describe 'GET #show' do
    context 'other user' do
      let(:startup) { create :startup, user: user }
      let!(:founder) { create :founder, startup: startup }

      before do
        @request.headers.merge! user_2.create_new_auth_token
        get :show, format: :json, id: founder.id
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns founder as json' do
        result = json['id']

        expect(result).to eq(founder.id)
      end
    end
  end

  describe 'POST #create' do
    let(:startup) { create :startup, user: user }
    let(:founder_attributes) { attributes_for(:founder, name: 'New founder') }

    before do
      @request.headers.merge! user.create_new_auth_token
      post :create, format: :json, id: startup.id, founder: founder_attributes
    end

    it { expect(response).to have_http_status(:success) }

    it 'creates founder' do
      last_founder = user.founders.last

      result = last_founder.name

      expect(result).to eq('New founder')
    end

    it 'sets startup' do
      last_founder = user.founders.last

      result = last_founder.startup_id

      expect(result).to eq(startup.id)
    end
  end

  describe 'PUT #update' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:founder) { create :founder, startup: startup }

    before do
      @request.headers.merge! token
      put :update, format: :json, id: founder.id,
          founder: { name: 'Updated founder' }
    end

    it { expect(response).to have_http_status(:success) }

    it 'updates founder data' do
      founder.reload

      result = founder.name

      expect(result).to eq('Updated founder')
    end

    context 'other user' do
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'DELETE #destroy' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:founder) { create :founder, startup: startup }

    before do
      @request.headers.merge! token
      delete :destroy, format: :json, id: founder.id
    end

    it { expect(response).to have_http_status(:success) }

    it 'destroys founder' do
      result = Founder.all

      expect(result).not_to include(founder)
    end

    context 'other user cannot destroy founder' do
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }

      it 'doesn\'t destroy the founder' do
        founder.reload

        result = founder

        expect(result).to be_persisted
      end
    end
  end
end
