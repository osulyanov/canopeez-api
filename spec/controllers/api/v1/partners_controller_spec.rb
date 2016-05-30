require 'rails_helper'

describe Api::V1::PartnersController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let!(:partner) { create :partner, name: 'Yandex' }
    let!(:partner_2) { create :partner, name: 'Gazprom' }

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns partners alphabet ordered as json' do
      result = json.map { |r| r['id'] }

      expect(result).to eq([partner_2.id, partner.id])
    end
  end
end
