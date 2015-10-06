class TeamFollower < ActiveRecord::Base
  # Database Fields
  # t.integer  "team_id",    null: false
  # t.integer  "user_id",    null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  # Relationships
  belongs_to :team
  belongs_to :user
  
  
  # Validation
  validates :team, presence: true
  validates :user, presence: true
end
