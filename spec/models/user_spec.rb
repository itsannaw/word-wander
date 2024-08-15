require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'John Doe', email: 'john@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(email: 'john@example.com', password: 'password')
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(name: 'John Doe', password: 'password')
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(name: 'John Doe', email: 'john@example.com')
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
      user = User.new(name: 'Jane Doe', email: 'john@example.com', password: 'password')
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'ransackable attributes' do
    it 'returns the correct ransackable attributes' do
      expect(User.ransackable_attributes).to eq(["created_at", "email", "id", "name", "updated_at"])
    end
  end

  describe 'ransackable associations' do
    it 'returns the correct ransackable associations' do
      expect(User.ransackable_associations).to eq([])
    end
  end
end
