class CommunityTeam < ActiveRecord::Base
  # Database Fields
  # t.integer  "team_id",      null: false
  # t.integer  "community_id", null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  # Relationships
  belongs_to :team
  belongs_to :community
  
  
  # Validation
  validates :team,      presence: true
  validates :community, presence: true
end
