class User < ActiveRecord::Base
  ## Database Fields
  # t.string   "first_name"
  # t.string   "last_name"
  # t.date     "birthday"
  # t.integer  "gender"
  # t.text     "overview"
  # t.text     "biography"
  # t.text     "goals"
  # t.text     "awards"
  # t.string   "headline"
  # t.string   "ask_about"
  # t.integer  "looking_for"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.string   "linkedin"
  # t.string   "github"
  # t.boolean  "is_superuser",           default: false, null: false
  # t.integer  "location_id"
  # t.string   "email",                                  null: false
  # t.string   "encrypted_password",                     null: false
  # t.string   "reset_password_token"
  # t.datetime "reset_password_sent_at"
  # t.integer  "sign_in_count",          default: 0,     null: false
  # t.datetime "current_sign_in_at"
  # t.datetime "last_sign_in_at"
  # t.string   "current_sign_in_ip"
  # t.string   "last_sign_in_ip"
  # t.string   "confirmation_token"
  # t.datetime "confirmed_at"
  # t.datetime "confirmation_sent_at"
  # t.string   "unconfirmed_email"
  # t.integer  "failed_attempts",        default: 0,     null: false
  # t.string   "unlock_token"
  # t.datetime "locked_at"
  # t.string   "authentication_token"
  # t.datetime "created_at",                             null: false
  # t.datetime "updated_at",                             null: false
  
  
  
  ## Actable (MTI)
  acts_as :handle
  
  
  
  ## Relationships
  has_and_belongs_to_many :skills,    class_name: :Tag,  join_table: :skills
  has_and_belongs_to_many :interests, class_name: :Tag,  join_table: :interests
  has_and_belongs_to_many :roles,     class_name: :Role, join_table: :user_roles
  
  has_many :educations
  has_many :experiences
  
  has_many :team_members
  has_many :teams, through: :team_members
  
  has_many :community_members
  has_many :communities, through: :community_members
  
  has_many :team_followers
  has_many :teams_followed, through: :team_followers, source: :team
  
  has_many :followed_user_followers, class_name: :UserFollower, foreign_key: :followed_id
  has_many :following, through: :followed_user_followers, source: :user
  
  has_many :follower_user_followers, class_name: :UserFollower, foreign_key: :follower_id
  has_many :followers, through: :follower_user_followers, source: :user
  
  belongs_to :location, autosave: true, dependent: :destroy
  
  has_and_belongs_to_many :contact_privacies, class_name: :Privacy, join_table: :user_contact_privacies
  
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Callbacks
  # Ensure that an authentication token always exists for every record
  before_save :ensure_authentication_token
  
  
  
  ## Enumerations
  enum gender: [
    :male,
    :female,
    :other,
    :decline
  ]
  enum looking_for: [
    :cofounder,
    :join_team,
    :create_team,
    :freelancing,
    :internship,
    :collaboration,
    :mentorship,
    :resources,
    :something_else
  ]
  
  
  
  ## Override name setter to titleize name
  def first_name=(first)
    super(first.to_s.strip.titleize)
  end
  def last_name=(last)
    super(last.to_s.strip.titleize)
  end
  
  
  
  ## Provide a method to set all user privacies from a hash
  def privacy=(hash)
    return if !hash.is_a?(Hash)
    self.contact_privacies = Privacy.construct(hash[:contact])
  end
  
  
  
  ## Intercept the roles/skills/interests setters to call each model's
  ##   construct() factory method
  def roles=(roles)
    super(Role.construct roles)
  end
  def skills=(skills)
    super(Tag.construct skills)
  end
  def interests=(interests)
    super(Tag.construct interests)
  end
  
  
  
  ## Provide a method to set the attributes of the location association
  def location=(data)
    if self.location.present? && !data.is_a?(Hash)
      self.location.destroy
    end
    
    if data.is_a?(Hash)
      if self.location.present?
        self.location.attributes = data
      else
        super(Location.new data)
      end
    else
      super(data)
    end
  end
  
  
  
  ## Method to grab all users that belong to a common team
  def teammates
    User.joins(:team_members).where(team_members: {team: teams})
  end
  
  
  
  ## Method to grab all users that belong to a common community
  def neighbors
    User.joins(:community_members).where(community_members: {community: communities})
  end
  
  
  
  ## Method to grab all connections
  def connections
    followers & following
  end
  
  
  
  ## Access Control
  # Checks if a user can read a certain record's data
  # Usage: user.can_read?(community, :profile)
  def can_read?(record, type_of_data)
    record.can_be_read_by?(self, type_of_data)
  end
  
  # Checks if a user can write a certain record's data
  # Usage: user.can_write?(community, :profile)
  def can_write?(record, type_of_data)
    record.can_be_written_by?(self, type_of_data)
  end
  
  # Gets the user's role in a particular record (team/community)
  # Usage: user.role_in(community)
  def role_in(record)
    record.role_of(self)
  end
  
  
  
  ## Other side of access control (checking if a user can read another user)
  def can_be_read_by?(user, type_of_data)
    case type_of_data
    when :contact
      privacies = contact_privacies.map(&:name)
      self === user || privacies.include?('public') ||
      privacies.include?('communities') && neighbors.include?(user) ||
      privacies.include?('teams')       && teammates.include?(user)
    else
      true
    end
  end
  
  
  
  ## Devise modules
  ## Unused options are: :timeoutable, :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :lockable, :confirmable
  
  
  ## Method to create an authentication token if one does not already exist
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
  
  
  ## Method to generate a unique authentication token
  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
