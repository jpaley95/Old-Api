class Tag < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",       null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  ## Relationships
  has_and_belongs_to_many :skilled,    class_name: :User, join_table: :skills
  has_and_belongs_to_many :interested, class_name: :User, join_table: :interests
  
  
  ## Validation
  validates :name, presence: true, uniqueness: true
  validate  :check_tag_format
  
  
  ## Validation routine to check if the tag is formatted correctly
  def check_tag_format
    errors.add(:name, 'is not a valid tag') unless name =~ Tag.validation_regex
  end
  
  
  ## Hashtag-matching regular expressions
  def self.validation_regex
    /^[a-z][a-z0-9]*$/
  end
  def self.scanning_regex
    /(?:^|\s)#([A-z][A-z0-9]*)/
  end
  
  
  ## Tag constructing function
  #  Takes an array of strings and produces an array of Tags
  #    1. Removes all whitespace and downcases all alphabetic characters
  #    2. Checks the database for the tag; if the tag does not exist,
  #         initializes a new Tag object
  def self.construct(tags)
    tags.map do |tag|
      Tag.where(name: tag.gsub(/\s+/, '').downcase).first_or_initialize
    end
  end
end
