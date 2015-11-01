class UserSerializer < ActiveModel::Serializer
  ## Attributes
  attributes :id,
             :first_name, :last_name,
             :birthday, :gender,
             :email, :username,
             :headline, :overview, :ask_about, :looking_for,
             :website, :facebook, :linkedin, :twitter,
             :status, :privacy,
             :created_at, :updated_at, :online_at
  
  
  ## Relationships
  has_many :roles
  has_many :skills
  has_many :interests
  has_one  :location, serializer: LocationSerializer
  
  
  ## Relationship serializers
  def roles
    object.roles.map(&:name)
  end
  
  def skills
    object.skills.map(&:name)
  end
  
  def interests
    object.interests.map(&:name)
  end
  
  
  ## Attribute serializers
  def status
    object.confirmed? ? 'confirmed' : 'unconfirmed'
  end
  
  def privacy
    { contact: object.contact_privacies.map(&:name) }
  end
  
  def online_at
    object.last_sign_in_at
  end
  
  
  ## Filter serialized hash based on permissions
  def filter(keys)
    privacies = object.contact_privacies.map(&:name)
    unless object === context                                                      ||
           privacies.include?('public')                                            ||
           privacies.include?('communities') && object.neighbors.include?(context) ||
           privacies.include?('teams')       && object.teammates.include?(context)
      keys.delete(:email)
      keys.delete(:location)
    end
    keys
  end
end