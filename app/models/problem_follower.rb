class ProblemFollower < ActiveRecord::Base
  # Database Fields
  # t.integer  "follower_id", null: false
  # t.integer  "followed_id", null: false
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  # Relationships
  belongs_to :user,    foreign_key: :follower_id
  belongs_to :problem, foreign_key: :followed_id
  
  
  # Validation
  validates :user,    presence: true
  validates :problem, presence: true
end
