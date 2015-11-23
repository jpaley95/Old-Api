class School < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",        null: false
  # t.integer  "location_id"
  # t.datetime "created_at",  null: false
  # t.datetime "updated_at",  null: false
  
  
  ## Relationships
  has_many :educations
  belongs_to :location
  
  
  ## Validation
  validates :name, presence: true
  
  
  
  ## Provide a method to set the attributes of the location association
  def location=(data)
    if self.location.present? && !data.is_a?(Hash)
      self.location.destroy
    end
    
    if data.is_a?(Hash)
      if self.location.present?
        self.location.attributes = data
      else
        super(Location.new data)
      end
    else
      super(data)
    end
  end
end
