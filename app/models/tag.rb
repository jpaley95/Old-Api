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
  
  
  
  ## Factory method
  def self.construct(data)
    # Non-enumerable
    if !data.is_a?(Enumerable)
      Tag.construct [data]
    
    # Enumerable of Tags
    elsif data.all? { |i| i.is_a?(Tag) }
      data
    
    # Enumerable of Strings
    # TODO: Fix n+1 query problem
    elsif data.all? { |i| i.is_a?(String) }
      data.map do |tag|
        Tag.where(name: tag.gsub(/\s+/, '').downcase).first_or_initialize
      end
    
    # Enumerable of unknowns
    else
      []
    end
  end
end
