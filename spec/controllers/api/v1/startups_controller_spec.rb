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

  describe 'GET #show' do
    context 'active' do
      let!(:startup) { create :startup, user: user }

      before do
        @request.headers.merge! user.create_new_auth_token
        get :show, format: :json, id: startup.id
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns startup as json' do
        result = json['id']

        expect(result).to eq(startup.id)
      end
    end

    context 'inactive' do
      context 'current user' do
        let!(:startup) { create :startup, user: user, is_active: false }

        before do
          @request.headers.merge! user.create_new_auth_token
          get :show, format: :json, id: startup.id
        end

        it { expect(response).to have_http_status(:success) }

        it 'returns startup as json' do
          result = json['id']

          expect(result).to eq(startup.id)
        end
      end

      context 'other user' do
        let!(:startup) { create :startup, user: user, is_active: false }

        before do
          @request.headers.merge! user_2.create_new_auth_token
          get :show, format: :json, id: startup.id
        end

        it { expect(response).to have_http_status(:unauthorized) }

        it 'returns startup as json' do
          result = json['message']

          expect(result).to be_present
        end
      end

      describe 'POST #create' do
        let(:token) { user.create_new_auth_token }
        let(:category) { create :category }
        let(:startup_attributes) do
          attributes_for(:startup, name: 'New startup',
                                   category_id: category.id)
        end

        before do
          @request.headers.merge! token
          post :create, format: :json, startup: startup_attributes
        end

        it { expect(response).to have_http_status(:success) }

        it 'creates startup' do
          last_startup = user.startups.last

          result = last_startup.name

          expect(result).to eq('New startup')
        end

        context 'anuthorized user' do
          let(:token) { {} }

          it { expect(response).to have_http_status(:unauthorized) }
        end
      end
    end
  end
end
