require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:post_params) { attributes_for(:post) }
  let!(:post) { create(:post, user: user) }

  before do
    request.headers.merge!(user.create_new_auth_token)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns paginated posts' do
      create_list(:post, 15)
      get :index, params: { page: 1, per_page: 10 }
      json = JSON.parse(response.body)
      expect(json['posts'].size).to eq(10)
    end

    context 'when filter is my' do
      it 'returns current user posts' do
        create_list(:post, 5, user: user)
        get :index, params: { filter: 'my' }
        json = JSON.parse(response.body)
        expect(json['posts'].all? { |p| p['user_id'] == user.id }).to be_truthy
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end
  end

describe 'PATCH #update' do
  it 'updates the post' do
    patch :update, params: { id: post.id, title: 'Updated Title' }
    post.reload
    expect(post.title).to eq('Updated Title')
  end

  it 'returns a success response' do
    patch :update, params: { id: post.id, title: 'Updated Title' }
    expect(response).to be_successful
  end

  it 'returns errors if post is invalid' do
    patch :update, params: { id: post.id, title: nil }
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

  describe 'DELETE #destroy' do
    it 'destroys the post' do
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it 'returns no content status' do
      delete :destroy, params: { id: post.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
