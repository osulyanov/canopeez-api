require 'rails_helper'

describe Api::V1::CommentsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    let(:startup) { create :startup, user: user }
    let!(:comment) do
      create :comment, user: user, startup: startup, comment: 'Wow!'
    end

    before do
      @request.headers.merge! user.create_new_auth_token
      get :index, format: :json, me: true
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns comments as json' do
      result = json.map { |r| r['id'] }

      expect(result).to contain_exactly(comment.id)
    end
  end

  describe 'POST #create' do
    let(:token) { user.create_new_auth_token }
    let(:startup) { create :startup, user: user }
    let!(:comment_attributes) { { startup_id: startup.id, comment: 'Test' } }

    before do
      @request.headers.merge! token
      post :create, format: :json, comment: comment_attributes
    end

    context 'logged in user' do
      it { expect(response).to have_http_status(:success) }

      it 'creates comment' do
        comment = user.comments.last

        result = comment.startup_id

        expect(result).to eq(startup.id)
      end
    end

    context 'guest user' do
      let(:token) { {} }

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
