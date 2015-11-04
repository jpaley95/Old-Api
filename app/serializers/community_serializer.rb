class CommunitySerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :username, :name,
             :headline, :description, :video,
             :policy, :signup_mode, :category,
             :website, :facebook, :twitter, :linkedin,
             :created_at, :founded_at,
             :privacy, :permission
  
  
  ## Relationships
  has_one  :parent
  has_many :children
  has_many :members
  has_many :teams
  has_many :listings
  has_many :resources
  has_one  :location, serializer: LocationSerializer
  
  
  ## Attribute serializers
  def privacy
    {
      events:    object.events_privacy.name,
      resources: object.resources_privacy.name
    }
  end
  
  def permission
    {
      profile:    object.profile_permission.name,
      members:    object.members_permission.name,
      children:   object.children_permission.name,
      statistics: object.statistics_permission.name,
      posts:      object.posts_permission.name,
      listings:   object.listings_permission.name,
      resources:  object.resources_permission.name,
      events:     object.events_permission.name
    }
  end
  
  
  ## Filter serialized hash based on privacy
  def filter(keys)
    if object.events_privacy.name === 'private' && CommunityMember.get_role(community: object, user: context).blank?
      keys.delete(:events)
    end
    
    if object.resources_privacy.name === 'private' && CommunityMember.get_role(community: object, user: context).blank?
      keys.delete(:resources)
    end
    
    keys
  end
end