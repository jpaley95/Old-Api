class CommunityMemberSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id
  
  
  ## Relationships
  has_one :user
  has_one :community
  has_one :role
  
  
  ## Relationship serializers
  def role
    object.role.name
  end
end