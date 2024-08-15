class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
