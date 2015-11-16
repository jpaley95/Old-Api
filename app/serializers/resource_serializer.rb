class ResourceSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id, :name,
             :overview,
             :website, :facebook, :twitter,
             :privacy
  
  
  ## Relationships
  has_one  :community
  has_many :categories
  has_one  :location, serializer: LocationSerializer
  
  
  ## Attribute serializers
  def privacy
    object.privacy.name
  end
  
  
  ## Relationship serializers
  def categories
    object.categories.map(&:name)
  end
end