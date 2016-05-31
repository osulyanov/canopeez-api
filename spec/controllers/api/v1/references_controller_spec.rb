require 'rails_helper'

describe Api::V1::ReferencesController, type: :controller do
  let(:user) { create :user }
  let(:user_2) { create :user }

  describe 'GET #index' do
    let(:startup) { create :startup, user: user }
    let!(:reference) { create :reference, startup: startup }

    before do
      @request.headers.merge! user_2.create_new_auth_token
      get :index, format: :json
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns references as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(reference.id)
    end
  end

  describe 'GET #show' do
    context 'other user' do
      let(:startup) { create :startup, user: user }
      let!(:reference) { create :reference, startup: startup }

      before do
        @request.headers.merge! user_2.create_new_auth_token
        get :show, format: :json, id: reference.id
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns reference as json' do
        result = json['id']

        expect(result).to eq(reference.id)
      end
    end
  end

  describe 'POST #create' do
    let(:startup) { create :startup, user: user }
    let(:reference_attributes) do
      attributes_for(:reference, description: 'New reference')
    end

    before do
      @request.headers.merge! user.create_new_auth_token
      post :create, format: :json, id: startup.id,
           reference: reference_attributes
    end

    context 'premium user' do
      let(:user) { create :user, is_premium: true }

      it { expect(response).to have_http_status(:success) }

      it 'creates reference' do
        last_reference = user.references.last

        result = last_reference.description

        expect(result).to eq('New reference')
      end

      it 'sets startup' do
        last_reference = user.references.last

        result = last_reference.startup_id

        expect(result).to eq(startup.id)
      end
    end

    context 'not premium user' do
      let(:user) { create :user, is_premium: false }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'PUT #update' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:reference) { create :reference, startup: startup }

    before do
      @request.headers.merge! token
      put :update, format: :json, id: reference.id,
          reference: { description: 'Updated reference' }
    end

    it { expect(response).to have_http_status(:success) }

    it 'updates reference data' do
      reference.reload

      result = reference.description

      expect(result).to eq('Updated reference')
    end

    context 'other user' do
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'DELETE #destroy' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:reference) { create :reference, startup: startup }

    before do
      @request.headers.merge! token
      delete :destroy, format: :json, id: reference.id
    end

    it { expect(response).to have_http_status(:success) }

    it 'destroys reference' do
      result = Reference.all

      expect(result).not_to include(reference)
    end

    context 'other user cannot destroy reference' do
      let(:token) { user_2.create_new_auth_token }

      it { expect(response).to have_http_status(:unauthorized) }

      it 'doesn\'t destroy the reference' do
        reference.reload

        result = reference

        expect(result).to be_persisted
      end
    end
  end
end
