class Degree < ActiveRecord::Base
  # Database Fields
  # t.string   "name",       null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  # Relationships
  has_many :educations
  
  
  # Validation
  validates :name, presence: true, uniqueness: true
  
  
  ## Degree constructing function
  #  Takes an array of strings and produces an array of Degrees
  #    1. Removes excess whitespace
  #    2. Checks the database for the degree; if the degree does not exist,
  #         initializes a new degree object
  def self.construct(degrees)
    degrees.map do |degree|
      Degree.where(name: degree.strip.squeeze(' ')).first_or_initialize
    end
  end
end
