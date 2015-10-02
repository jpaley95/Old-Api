class Role < ActiveRecord::Base
  # Database Fields
  # t.string "name", null: false
  
  
  # Relationships
  has_and_belongs_to_many :users, join_table: :user_roles
  
  
  # Validation
  validates :name, presence: true, uniqueness: true
end
