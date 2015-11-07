class Permission < ActiveRecord::Base
  # Database Fields
  # t.string "name", null: false
  
  
  
  # Validation
  validates :name, presence: true, uniqueness: true
  
  
  
  ## Factory method
  def self.construct(data)
    # Non-enumerable
    if !data.is_a?(Enumerable)
      Permission.construct [data]
    
    # Enumerable of Permissions
    elsif data.all? { |i| i.is_a?(Permission) }
      data
    
    # Enumerable of Strings
    elsif data.all? { |i| i.is_a?(String) }
      Permission.where(name: data.map(&:downcase).map!(&:strip))
    
    # Enumerable of unknowns
    else
      []
    end
  end
end
