class ListingSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :title, :description, :skills,
             :positions, :category, :salary_period,
             :started_at, :finished_at,
             :deadline,
             :salary_min, :salary_max, :hours,
             :equity_min, :equity_max,
             :privacy,
             :location
  
  
  ## Relationships
  has_one  :user
  has_one  :owner
  has_one  :location, serializer: LocationSerializer
  has_many :members
  has_many :skills
  
  
  ## Attribute serializers
  def privacy
    object.privacy.name
  end
  
  
  ## Relationship serializers
  def skills
    object.skills.map(&:name)
  end
end