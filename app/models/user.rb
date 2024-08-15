# frozen_string_literal: true
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :posts, dependent: :delete_all
  has_many :comments,  dependent: :delete_all

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
