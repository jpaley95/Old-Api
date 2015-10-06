class Post < ActiveRecord::Base
  ## Database Fields
# t.integer  "handle_id",  null: false
# t.integer  "user_id",    null: false
# t.text     "content",    null: false
# t.integer  "privacy_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :handle
  belongs_to :user
  belongs_to :privacy
  has_many :files, as: :owner
  
  
  
  ## Validation
  validates :user, presence: true
  validates :handle, presence: true
  validates :privacy, presence: true
  validates :content, presence: true
end
