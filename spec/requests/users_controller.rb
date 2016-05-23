require 'rails_helper'

describe 'Api::V1::UsersController', type: :request do
  describe 'POST #sign_in' do
    let!(:user) { create :user, email: 'user@example.com', password: 'pass123' }

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
end
