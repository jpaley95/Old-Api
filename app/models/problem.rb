class Problem < ActiveRecord::Base
  # Database Fields
  # t.string   "name",               null: false
  # t.text     "text",               null: false
  # t.string   "photo_file_name",    null: false
  # t.string   "photo_content_type", null: false
  # t.integer  "photo_file_size",    null: false
  # t.datetime "photo_updated_at",   null: false
  # t.integer  "location_id"
  # t.integer  "user_id",            null: false
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  ## Relationships
  belongs_to :user
  
  belongs_to :location
  
  has_many :problem_followers, foreign_key: :followed_id
  has_many :followers, through: :problem_followers, source: :user
  
  has_many :problem_promoters, foreign_key: :promoted_id
  has_many :promoters, through: :problem_promoters, source: :user
  
  has_attached_file :photo, styles: { fluid: "300x", medium: "300x300#", thumb: "100x100#" }
  
  
  ## Validation
  validates :name, presence: true
  validates :text, presence: true
  validates :user, presence: true
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :photo
end