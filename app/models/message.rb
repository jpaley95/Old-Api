class Message < ActiveRecord::Base
  ## Database Fields
  # t.integer  "handle_id",  null: false
  # t.integer  "user_id",    null: false
  # t.text     "content",    null: false
  # t.integer  "thread_id",  null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  belongs_to :user
  belongs_to :handle
  belongs_to :thread
  has_many :files, as: :owner
  
  
  
  ## Validation
  validates :user, presence: true
  validates :handle, presence: true
  validates :thread, presence: true
  validates :content, presence: true
end
