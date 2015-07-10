class User < ActiveRecord::Base
  ## Database Fields
  # t.string   "first_name"
  # t.string   "last_name"
  # t.date     "birthday"
  # t.integer  "gender"
  # t.string   "photo_file_name"
  # t.string   "photo_content_type"
  # t.integer  "photo_file_size"
  # t.datetime "photo_updated_at"
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
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  
  
  ## Actable (MTI)
  acts_as :handle
  
  
  
  ## Relationships
  has_many :problems
  
  has_many :problem_followers, foreign_key: :follower_id
  has_many :problems_followed, through: :problem_followers, source: :problem
  
  has_many :problem_promoters, foreign_key: :promoter_id
  has_many :problems_promoted, through: :problem_promoters, source: :problem
  
  has_many :followed_user_followers, class_name: :UserFollower, foreign_key: :followed_id
  has_many :following, through: :followed_user_followers, source: :user
  
  has_many :follower_user_followers, class_name: :UserFollower, foreign_key: :follower_id
  has_many :followers, through: :follower_user_followers, source: :user
  
  belongs_to :location
  
  has_and_belongs_to_many :roles_rel, join_table: :user_roles, class_name: :Role
  
  has_attached_file :photo, styles: { fluid: "300x", medium: "300x300#", thumb: "100x100#" }
  
  
  
  ## Validation
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  
  
  ## Callbacks
  # Ensure that an authentication token always exists for every record
  before_save :ensure_authentication_token
  
  
  
  ## Enums
  enum gender: [:male, :female, :other, :none]
  enum looking_for: [
    :cofounder,
    :join_team,
    :create_team,
    :freelancing,
    :internship,
    :collaboration,
    :mentorship,
    :management,
    :resources
  ]
  
  
  
  ## Override name setter to titleize name
  def first_name=(s)
    write_attribute(:first_name, s.to_s.strip.titleize)
  end
  def last_name=(s)
    write_attribute(:last_name,  s.to_s.strip.titleize)
  end
  
  
  
  ## Override roles setter and getter
  def valid_roles
    ['entrepreneur', 'freelancer', 'instructor', 'mentor']
  end
  def roles
    roles_rel.map(&:name)
  end
  def roles=(roles)
    roles = valid_roles & roles.map(&:downcase).map!(&:strip)
    self.roles_rel = Role.where(name: roles)
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
