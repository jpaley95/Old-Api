class Privacy < ActiveRecord::Base
  # Database Fields
  # t.string "name", null: false
  
  
  # Validation
  validates :name, presence: true, uniqueness: true
end
