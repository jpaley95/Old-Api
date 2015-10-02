class School < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",        null: false
  # t.integer  "location_id"
  # t.datetime "created_at",  null: false
  # t.datetime "updated_at",  null: false
  
  
  ## Relationships
  has_many :educations
  belongs_to :location
  
  
  ## Validation
  validates :name, presence: true
end
