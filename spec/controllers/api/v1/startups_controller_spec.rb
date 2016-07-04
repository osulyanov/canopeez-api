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

    describe 'partner_ids' do
      context 'premium user' do
        let(:user) { create :user, is_premium: true }
        let(:partner) { create :partner }
        let(:startup_attributes) do
          attributes_for(:startup, name: 'New startup',
                         category_id: category.id, partner_ids: [partner.id])
        end

        it 'sets partners' do
          startup = user.startups.last

          result = startup.partner_ids

          expect(result).to contain_exactly(partner.id)
        end
      end

      context 'not premium user' do
        let(:user) { create :user, is_premium: false }
        let(:partner) { create :partner }
        let(:startup_attributes) do
          attributes_for(:startup, name: 'New startup',
                         category_id: category.id, partner_ids: [partner.id])
        end

        it 'doesn\'t sets partners' do
          startup = user.startups.last

          result = startup.partner_ids

          expect(result).to be_empty
        end
      end
    end

    describe 'reference_ids' do
      context 'premium user' do
        let(:user) { create :user, is_premium: true }
        let(:reference) { create :reference }
        let(:startup_attributes) do
          attributes_for(:startup, name: 'New startup',
                                   category_id: category.id,
                                   reference_ids: [reference.id])
        end

        it 'sets references' do
          startup = user.startups.last

          result = startup.reference_ids

          expect(result).to contain_exactly(reference.id)
        end
      end

      context 'not premium user' do
        let(:user) { create :user, is_premium: false }
        let(:reference) { create :reference }
        let(:startup_attributes) do
          attributes_for(:startup, name: 'New startup',
                                   category_id: category.id,
                                   reference_ids: [reference.id])
        end

        it 'doesn\'t sets references' do
          startup = user.startups.last

          result = startup.reference_ids

          expect(result).to be_empty
        end
      end
    end

    context 'anuthorized user' do
      let(:token) { {} }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'PUT #update' do
    let(:token) { user.create_new_auth_token }
    let!(:startup) { create :startup, user: user }

    before do
      @request.headers.merge! token
      put :update, format: :json, id: startup.id,
          startup: { name: 'Updated startup' }
    end

    it { expect(response).to have_http_status(:success) }

    it 'updates startup data' do
      startup.reload

      result = startup.name

      expect(result).to eq('Updated startup')
    end

    context 'other user' do
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'DELETE #destroy' do
    let(:token) { user.create_new_auth_token }
    let!(:startup) { create :startup, user: user }

    before do
      @request.headers.merge! token
      delete :destroy, format: :json, id: startup.id
    end

    it { expect(response).to have_http_status(:success) }

    it 'destroys startup' do
      result = Startup.all

      expect(result).not_to include(startup)
    end

    context 'other user cannot destroy startup' do
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }

      it 'doesn\'t destroy the startup' do
        startup.reload

        result = startup

        expect(result).to be_persisted
      end
    end
  end
end
