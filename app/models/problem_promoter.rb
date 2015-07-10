class ProblemFollower < ActiveRecord::Base
  # Database Fields
  # t.integer  "promoter_id", null: false
  # t.integer  "promoted_id", null: false
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  # Relationships
  belongs_to :user,    foreign_key: :promoter_id
  belongs_to :problem, foreign_key: :promoted_id
  
  
  # Validation
  validates :user,    presence: true
  validates :problem, presence: true
end
