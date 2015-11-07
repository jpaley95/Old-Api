class Degree < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",       null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  ## Relationships
  has_many :educations
  
  
  ## Validation
  validates :name, presence: true, uniqueness: true
  
  
  ## Factory method
  def self.construct(data)
    # Non-enumerable
    if !data.is_a?(Enumerable)
      Degree.construct [data]
    
    # Enumerable of Degree
    elsif data.all? { |i| i.is_a?(Degree) }
      data
    
    # Enumerable of Strings
    # TODO: Fix n+1 query problem
    elsif data.all? { |i| i.is_a?(String) }
      data.map do |degree|
        Degree.where(name: degree.strip.squeeze(' ')).first_or_initialize
      end
    
    # Enumerable of unknowns
    else
      []
    end
  end
end
