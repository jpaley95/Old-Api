class Category < ActiveRecord::Base
  ## Database Fields
  # t.string "name",        null: false
  # t.text   "description"
  
  
  
  ## Relationships
  has_and_belongs_to_many :resources, join_table: :resource_categories
  
  
  
  ## Validation
  validates :name, presence: true
end
