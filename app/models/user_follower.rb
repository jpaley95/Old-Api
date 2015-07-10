class UserFollower < ActiveRecord::Base
  # Database Fields
  # t.integer  "follower_id", null: false
  # t.integer  "followed_id", null: false
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  # Relationships
  belongs_to :follower, foreign_key: :follower_id, class_name: :User
  belongs_to :followed, foreign_key: :followed_id, class_name: :User
  
  
  # Validation
  validates :follower, presence: true
  validates :followed, presence: true
end
