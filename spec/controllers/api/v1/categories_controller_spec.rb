require 'rails_helper'

describe Api::V1::CategoriesController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let!(:category) { create :category, name: 'Toys' }
    let!(:category_2) { create :category, name: 'Cars' }

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns categories alphabet ordered as json' do
      result = json.map { |r| r['id'] }

      expect(result).to eq([category_2.id, category.id])
    end
  end
end
