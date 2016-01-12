class File < ActiveRecord::Base
  ## Database Fields
  # t.string   "type",                 null: false
  # t.string   "name"
  # t.text     "description"
  # t.string   "payload_file_name",    null: false
  # t.string   "payload_content_type", null: false
  # t.integer  "payload_file_size",    null: false
  # t.datetime "payload_updated_at",   null: false
  # t.integer  "user_id",              null: false
  # t.datetime "created_at",           null: false
  # t.datetime "updated_at",           null: false
  
  
  
  ## Relationships
  belongs_to :user
  
  
  
  ## Validation
  validates :user,  presence: true
end