require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      post = user.posts.new(title: 'Test Post', description: 'Test Content')
      post.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test.png')), filename: 'test.png', content_type: 'image/png')
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      post = user.posts.new(description: 'Test Content')
      post.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test.png')), filename: 'test.png', content_type: 'image/png')
      expect(post).to_not be_valid
    end

    it 'is not valid without a description' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      post = user.posts.new(title: 'Test Post')
      post.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test.png')), filename: 'test.png', content_type: 'image/png')
      expect(post).to_not be_valid
    end

    it 'is not valid without an image' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      post = user.posts.new(title: 'Test Post', description: 'Test Content')
      expect(post).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'ransackable attributes' do
    it 'returns the correct ransackable attributes' do
      expect(Post.ransackable_attributes).to eq(["created_at", "description", "id", "title", "updated_at", "user_id"])
    end
  end

  describe 'ransackable associations' do
    it 'returns the correct ransackable associations' do
      expect(Post.ransackable_associations).to eq(["user"])
    end
  end
end
