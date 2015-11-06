class TeamMemberSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id, :title
  
  
  ## Relationships
  has_one :user
  has_one :team
  has_one :role
  
  
  ## Relationship serializers
  def role
    object.role.name
  end
end