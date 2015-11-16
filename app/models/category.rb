class Category < ActiveRecord::Base
  ## Database Fields
  # t.string "name",         null: false
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  
  ## Relationships
  has_and_belongs_to_many :resources, join_table: :resource_categories
  
  
  
  ## Validation
  validates :name, presence: true, uniqueness: true
  
  
  
  ## Factory method
  def self.construct(data)
    # Non-enumerable
    if !data.is_a?(Enumerable)
      Category.construct [data]
    
    # Enumerable of Categories
    elsif data.all? { |i| i.is_a?(Category) }
      data
    
    # Enumerable of Strings
    elsif data.all? { |i| i.is_a?(String) }
      Category.where(name: data.map!(&:strip))
    
    # Enumerable of unknowns
    else
      []
    end
  end
end