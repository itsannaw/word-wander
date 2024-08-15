require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'Comments routes' do
    it 'routes to comments#index' do
      expect(get: '/comments').to route_to('comments#index')
    end

    it 'routes to comments#show' do
      expect(get: '/comments/1').to route_to('comments#show', id: '1')
    end

    it 'routes to comments#create' do
      expect(post: '/comments').to route_to('comments#create')
    end

    it 'routes to comments#update' do
      expect(put: '/comments/1').to route_to('comments#update', id: '1')
    end

    it 'routes to comments#destroy' do
      expect(delete: '/comments/1').to route_to('comments#destroy', id: '1')
    end
  end

  describe 'Posts routes' do
    it 'routes to posts#index' do
      expect(get: '/posts').to route_to('posts#index')
    end

    it 'routes to posts#show' do
      expect(get: '/posts/1').to route_to('posts#show', id: '1')
    end

    it 'routes to posts#create' do
      expect(post: '/posts').to route_to('posts#create')
    end

    it 'routes to posts#update' do
      expect(put: '/posts/1').to route_to('posts#update', id: '1')
    end

    it 'routes to posts#destroy' do
      expect(delete: '/posts/1').to route_to('posts#destroy', id: '1')
    end
  end

  describe 'Devise Token Auth routes' do
    it 'mounts Devise Token Auth at /auth' do
      expect(get: '/auth/sign_in').to route_to('devise_token_auth/sessions#new')
    end

    it 'routes to custom_registrations#create' do
      expect(post: '/auth').to route_to('custom_registrations#create')
    end
  end

  describe 'Health check route' do
    it 'routes to rails/health#show' do
      expect(get: '/up').to route_to('rails/health#show')
    end
  end

  describe 'Root route' do
    it 'routes to admin/dashboard#index' do
      expect(get: '/').to route_to('admin/dashboard#index')
    end
  end
end
