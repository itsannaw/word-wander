require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      admin_user = AdminUser.new(email: 'admin@example.com', password: 'password')
      expect(admin_user).to be_valid
    end

    it 'is not valid without an email' do
      admin_user = AdminUser.new(password: 'password')
      expect(admin_user).to_not be_valid
    end

    it 'is not valid without a password' do
      admin_user = AdminUser.new(email: 'admin@example.com')
      expect(admin_user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      AdminUser.create(email: 'admin@example.com', password: 'password')
      admin_user = AdminUser.new(email: 'admin@example.com', password: 'password')
      expect(admin_user).to_not be_valid
    end
  end

  describe 'ransackable attributes' do
    it 'returns the correct ransackable attributes' do
      expect(AdminUser.ransackable_attributes).to eq(["created_at", "email", "id", "updated_at"])
    end
  end

  describe 'ransackable associations' do
    it 'returns the correct ransackable associations' do
      expect(AdminUser.ransackable_associations).to eq([])
    end
  end
end
