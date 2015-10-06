class ListingMember < ActiveRecord::Base
  ## Database Fields
  # t.integer  "user_id",    null: false
  # t.integer  "listing_id", null: false
  # t.text     "review"
  # t.integer  "rating"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :user
  belongs_to :listing
  
  
  
  ## Validation
  validates :user, presence: true
  validates :listing, presence: true
end
