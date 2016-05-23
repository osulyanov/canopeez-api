require 'rails_helper'

describe 'Api::V1::UsersController', type: :request do
  describe 'POST #sign_in' do
    let!(:user) { create :user, email: 'user@example.com', password: 'pass123' }

    context 'correct data' do
      before do
        post '/api/v1/users/sign_in', email: 'user@example.com',
                                      password: 'pass123'
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns current user as json' do
        result = json['data']['id']

        expect(result).to eq(user.id)
      end
    end

    context 'incorrect data' do
      before do
        post '/api/v1/users/sign_in', email: 'user@example.com',
                                      password: 'wrongpass'
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it 'returns error' do
        result = json['errors']

        expect(result).to be_present
      end
    end
  end
end
