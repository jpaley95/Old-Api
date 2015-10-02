class Field < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",       null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  ## Relationships
  has_and_belongs_to_many :majors, class_name: :Education, join_table: :majors
  has_and_belongs_to_many :minors, class_name: :Education, join_table: :minors
  
  
  ## Validation
  validates :name, presence: true, uniqueness: true
  
  
  ## Field constructing function
  #  Takes an array of strings and produces an array of Fields
  #    1. Removes excess whitespace
  #    2. Checks the database for the field; if the field does not exist,
  #         initializes a new field object
  def self.construct(fields)
    fields.map do |field|
      Field.where(name: field.strip.squeeze(' ')).first_or_initialize
    end
  end
end
