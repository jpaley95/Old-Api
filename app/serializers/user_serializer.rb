class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name, :last_name,
             :birthday, :gender,
             :email, :username,
             :headline, :overview, :ask_about, :looking_for, :roles,
             :website, :facebook, :linkedin, :twitter,
             :status, :privacy,
             :created_at, :updated_at, :online_at
  
  
  
  has_many :roles
  has_many :skills
  has_many :interests
  
  
  
  def status
    object.confirmed? ? 'confirmed' : 'unconfirmed'
  end
  
  def online_at
    object.last_sign_in_at
  end
  
  def roles
    object.roles.map(&:name)
  end
  
  def skills
    object.skills.map(&:name)
  end
  
  def interests
    object.interests.map(&:name)
  end
end
