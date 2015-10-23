class Privacy < ActiveRecord::Base
  # Database Fields
  # t.string "name", null: false
  
  
  
  # Validation
  validates :name, presence: true, uniqueness: true
  
  
  
  ## Factory method
  def self.construct(data)
    # Non-enumerable
    if !data.is_a?(Enumerable)
      Privacy.construct [data]
    
    # Enumerable of Privacies
    elsif data.all? { |i| i.is_a?(Privacy) }
      data
    
    # Enumerable of Strings
    elsif data.all? { |i| i.is_a?(String) }
      Privacy.where(name: data.map(&:downcase).map!(&:strip))
    
    # Enumerable of unknowns
    else
      []
    end
  end
end
