require 'rails_helper'

describe 'Api::V1::UsersController', type: :request do
  describe 'Sign In' do
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

  describe 'Sign Up' do
    context 'correct data' do
      before do
        post '/api/v1/users.json', email: 'em@il.ru', password: '123456',
                                   password_confirmation: '123456'
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns success status as json' do
        result = json['status']

        expect(result).to eq('success')
      end

      it 'returns current user as json' do
        result = json['data']['id']

        expect(result).to be_present
      end
    end

    context 'incorrect data' do
      before do
        post '/api/v1/users.json', email: 'em@il.ru', password: '123456',
                                   password_confirmation: '12345'
      end

      it { expect(response).to have_http_status(:forbidden) }

      it 'returns error status as json' do
        result = json['status']

        expect(result).to eq('error')
      end

      it 'returns current user as json' do
        result = json['data']['id']

        expect(result).to be_blank
      end
    end
  end
end
