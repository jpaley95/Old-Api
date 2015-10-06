class Document < File
  ## Database Fields
  # t.string   "type",                 null: false
  # t.string   "name"
  # t.text     "description"
  # t.string   "payload_file_name",    null: false
  # t.string   "payload_content_type", null: false
  # t.integer  "payload_file_size",    null: false
  # t.datetime "payload_updated_at",   null: false
  # t.integer  "user_id",              null: false
  # t.integer  "owner_id",             null: false
  # t.string   "owner_type",           null: false
  # t.datetime "created_at",           null: false
  # t.datetime "updated_at",           null: false
  
  
  
  ## Relationships
  has_attached_file :payload, styles: { fluid: "300x", medium: "300x300#", thumb: "100x100#" }
  
  
  
  ## Validation
  validates :payload, attachment_presence: true
  validates_attachment_content_type :payload, content_type: [
    'text/plain',
    'application/pdf',
    'application/msword',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  ]
end
