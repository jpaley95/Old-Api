class Resource < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",         null: false
  # t.string   "contact"
  # t.text     "overview"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.string   "linkedin"
  # t.integer  "privacy_id",   null: false
  # t.integer  "community_id", null: false
  # t.integer  "location_id"
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  
  ## Actable (MTI)
  acts_as :handle
  
  
  
  ## Relationships
  belongs_to :community
  belongs_to :privacy
  belongs_to :location
  
  has_and_belongs_to_many :tags,       join_table: :resource_tags
  has_and_belongs_to_many :categories, join_table: :resource_categories
  
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Validation
  validates :name,      presence: true
  validates :privacy,   presence: true
  validates :community, presence: true
end
