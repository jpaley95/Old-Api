class TeamSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :username, :name,
             :tagline, :contact, :summary,
             :website, :facebook, :twitter, :linkedin, :github,
             :sectors,
             :founded_at,
             :privacy, :permission
  
  
  ## Relationships
  has_many :kpis
  has_many :posts
  has_many :listings
  has_one  :location, serializer: LocationSerializer
  
  
  ## Attribute serializers
  def privacy
    {
      contact: object.contact_privacies.map(&:name),
      kpis:    object.kpis_privacies.map(&:name)
    }
  end
  
  def permission
    {
      listings: object.listings_permissions.map(&:name),
      profile:  object.profile_permissions.map(&:name),
      posts:    object.posts_permissions.map(&:name),
      kpis:     object.kpis_permissions.map(&:name)
    }
  end
  
  
  ## Filter serialized hash based on privacy
  def filter(keys)
    unless context.can_read?(object, :contact)
      keys.delete(:contact)
      keys.delete(:location)
    end
    
    unless context.can_read?(object, :kpis)
      keys.delete(:kpis)
    end
    
    keys
  end
end