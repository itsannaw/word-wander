require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      post = Post.create(title: 'Test Post', description: 'Test Content', user: user)
      comment = Comment.new(body: 'Test Comment', user: user, post: post)
      expect(comment).to be_valid
    end

    it 'is not valid without a body' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      post = Post.create(title: 'Test Post', description: 'Test Content', user: user)
      comment = Comment.new(user: user, post: post)
      expect(comment).to_not be_valid
    end

    it 'is not valid without a user' do
      post = Post.create(title: 'Test Post', description: 'Test Content')
      comment = Comment.new(body: 'Test Comment', post: post)
      expect(comment).to_not be_valid
    end

    it 'is not valid without a post' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      comment = Comment.new(body: 'Test Comment', user: user)
      expect(comment).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'ransackable attributes' do
    it 'returns the correct ransackable attributes' do
      expect(Comment.ransackable_attributes).to eq(["body", "created_at", "id", "post_id", "updated_at", "user_id"])
    end
  end

  describe 'ransackable associations' do
    it 'returns the correct ransackable associations' do
      expect(Comment.ransackable_associations).to eq(["post", "user"])
    end
  end
end
