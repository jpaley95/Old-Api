class Experience < ActiveRecord::Base
  ## Database Fields
  # t.string   "title"
  # t.text     "description"
  # t.string   "organization"
  # t.integer  "team_id"
  # t.date     "started_at"
  # t.date     "finished_at"
  # t.integer  "location_id"
  # t.integer  "user_id",      null: false
  # t.datetime "created_at",   null: false
  # t.datetime "updated_at",   null: false
  
  
  
  ## Relationships
  belongs_to :user
  belongs_to :team
  belongs_to :location
  
  
  
  ## Validation
  validates :user, presence: true
  validate :only_one_organization_specified
  
  
  
  ## Custom validator to make sure an Experience record either has a related
  ##   Team record or a custom organization field
  def only_one_organization_specified
    unless team.blank? ^ organization.blank?
      errors.push(:organization, 'is required and only one may be specified')
    end
  end
  
  
  
  ## Provide a method to set the attributes of the location association
  def location=(data)
    if location.present? && !data.is_a?(Hash)
      location.destroy
    end
    
    if data.is_a?(Hash)
      if location.present?
        location.attributes = data
      else
        super(Location.new data)
      end
    else
      super(data)
    end
  end
end
