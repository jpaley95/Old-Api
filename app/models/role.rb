class Role < ActiveRecord::Base
  ## Database Fields
  # t.string "name", null: false
  
  
  
  ## Relationships
  has_and_belongs_to_many :users, join_table: :user_roles
  
  
  
  ## Validation
  validates :name, presence: true, uniqueness: true
  
  
  
  ## Factory method
  def self.construct(data)
    # Non-enumerable
    if !data.is_a?(Enumerable)
      Role.construct [data]
    
    # Enumerable of Roles
    elsif data.all? { |i| i.is_a?(Role) }
      data
    
    # Enumerable of Strings
    elsif data.all? { |i| i.is_a?(String) }
      Role.where(name: data.map(&:downcase).map!(&:strip))
    
    # Enumerable of unknowns
    else
      []
    end
  end
end