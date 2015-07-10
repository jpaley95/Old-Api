class Handle < ActiveRecord::Base
  # Database Fields
  # t.string   "username",     null: false
  # t.integer  "actable_id",   null: false
  # t.string   "actable_type", null: false
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  # Actable (MTI)
  actable
  
  
  # Validation
  validates :username, presence: true, uniqueness: true
  validate  :check_username_format
  
  
  # Validation routine to check if the username is formatted correctly
  def check_username_format
    errors.add(:username, "is not a valid username") unless username =~ Handle.validation_regex
  end
  
  
  # Handle-matching regular expressions
  def self.validation_regex
    /^[a-z0-9_]{1,15}$/
  end
  def self.scanning_regex
    /(?:^|\s)@([A-z0-9_]{1,15})/
  end
  
  
  
  # Override username setter to fix the following formatting mistakes
  #   - leading and/or trailing whitespace
  #   - uppercase characters
  #   - leading at character
  def username=(s)
    write_attribute(:username, s.to_s.strip.sub(/^@/, '').downcase)
  end
  
  
  # Override to_s
  def to_s
    '@' + username
  end
end