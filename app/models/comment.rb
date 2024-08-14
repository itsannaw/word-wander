class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "post_id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end
end
