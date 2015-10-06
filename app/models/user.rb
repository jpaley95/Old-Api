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
  # t.integer  "privacy"
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
  has_many :community_members
  
  has_many :team_followers
  has_many :teams_followed, through: :team_followers, source: :team
  
  has_many :followed_user_followers, class_name: :UserFollower, foreign_key: :followed_id
  has_many :following, through: :followed_user_followers, source: :user
  
  has_many :follower_user_followers, class_name: :UserFollower, foreign_key: :follower_id
  has_many :followers, through: :follower_user_followers, source: :user
  
  belongs_to :location
  
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
  def first_name=(s)
    write_attribute(:first_name, s.to_s.strip.titleize)
  end
  def last_name=(s)
    write_attribute(:last_name,  s.to_s.strip.titleize)
  end
  
  
  
  ## Override roles setter
  def self.roles_whitelist
    ['entrepreneur', 'freelancer', 'instructor', 'mentor', 'student', 'other']
  end
  def roles=(roles)
    names  = User.roles_whitelist & roles.map(&:downcase).map!(&:strip)
    @roles = Role.where(name: names)
  end
  
  
  
  ## Override skills and interests setters
  def skills=(skills)
    @skills = Tag.construct(skills)
  end
  def interests=(interests)
    @interests = Tag.construct(interests)
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
