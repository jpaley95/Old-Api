class Listing < ActiveRecord::Base
  ## Database Fields
  # t.integer  "handle_id",    null: false
  # t.string   "title",        null: false
  # t.text     "description"
  # t.integer  "location_id"
  # t.integer  "positions"
  # t.integer  "category"
  # t.integer  "hours"
  # t.datetime "started_at"
  # t.datetime "finished_at"
  # t.datetime "closed_at"
  # t.integer  "salaryMin"
  # t.integer  "salaryMax"
  # t.integer  "salaryPeriod"
  # t.integer  "equityMin"
  # t.integer  "equityMax"
  # t.integer  "privacy_id",   null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  
  ## Relationships
  belongs_to :handle
  belongs_to :privacy
  belongs_to :location
  has_many :members, class_name: :ListingMember
  has_and_belongs_to_many :skills, class_name: :Tag, join_table: :listing_skills
  
  
  
  ## Validation
  validates :title, presence: true
  validates :handle, presence: true
  validates :privacy, presence: true
end
