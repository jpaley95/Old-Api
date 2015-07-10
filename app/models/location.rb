class Location < ActiveRecord::Base
  # Database Fields
  # t.string   "description"
  # t.string   "street"
  # t.string   "city"
  # t.string   "state"
  # t.string   "zip"
  # t.string   "country"
  # t.decimal  "latitude"
  # t.decimal  "longitude"
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  # Relationships
  
  
  # Validation
  
  
  # Override to_s
  def to_s
    if description.present?
      description
    elsif city.present? && state.present?
      city.titleize + ', ' + state.titleize + ' Area'
    elsif country.present?
      country.titleize
    else
      'An Unspecified Location'
    end
  end
end
