class Experience < ActiveRecord::Base
  ## Database Fields
  # t.string   "title"
  # t.text     "description"
  # t.string   "organization"
  # t.integer  "team_id"
  # t.date     "started_at"
  # t.date     "finished_at"
  # t.integer  "location_id"
  # t.integer  "user_id",      null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  ## Relationships
  belongs_to :user
  belongs_to :team
  belongs_to :location
  
  
  ## Validation
  validates :user, presence: true
end
