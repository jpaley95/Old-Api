class Team < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",        null: false
  # t.string   "tagline"
  # t.string   "contact"
  # t.text     "summary"
  # t.string   "stage"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.string   "linkedin"
  # t.string   "github"
  # t.boolean  "commercial"
  # t.boolean  "research"
  # t.boolean  "social"
  # t.date     "founded_at"
  # t.integer  "location_id"
  # t.datetime "created_at",  null: false
  # t.datetime "updated_at",  null: false
  
  
  
  ## Relationships
  has_many :members, class_name: :TeamMember
  has_many :users, through: :members
  
  has_many :community_teams
  has_many :communities, through: :community_teams
  
  has_many :team_followers
  has_many :followers, through: :team_followers, source: :user
  
  has_and_belongs_to_many :listings_permissions, class_name: :Permission, join_table: :team_listings_permissions
  has_and_belongs_to_many :kpis_permissions,     class_name: :Permission, join_table: :team_kpis_permissions
  has_and_belongs_to_many :profile_permissions,  class_name: :Permission, join_table: :team_profile_permissions
  has_and_belongs_to_many :posts_permissions,    class_name: :Permission, join_table: :team_posts_permissions
  has_and_belongs_to_many :inbox_permissions,    class_name: :Permission, join_table: :team_inbox_permissions
  
  has_and_belongs_to_many :kpis_privacies,    class_name: :Privacy, join_table: :team_kpis_privacies
  has_and_belongs_to_many :contact_privacies, class_name: :Privacy, join_table: :team_contact_privacies
  
  has_and_belongs_to_many :industries, class_name: :Tag,  join_table: :industries
  
  has_many :kpis
  
  belongs_to :location
  
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Validation
  validates :name, presence: true
  
  
  
  ## Intercept industries setters and call Tag factory method
  def industries=(industries)
    super(Tag.construct industries)
  end
  
  
  
  ## Provide a method to get/set all team sectors
  def sectors
    sectors = []
    sectors.push 'commercial' if commercial
    sectors.push 'social'     if social
    sectors.push 'research'   if research
    sectors
  end
  def sectors=(arr)
    return if !arr.is_a?(Array)
    self.commercial = arr.include?('commercial')
    self.research   = arr.include?('research')
    self.social     = arr.include?('social')
  end
  
  
  
  ## Provide a method to set all team privacies from a hash
  def privacy=(hash)
    return if !hash.is_a?(Hash)
    self.kpis_privacies    = Privacy.construct(hash[:kpis])
    self.contact_privacies = Privacy.construct(hash[:contact])
  end
  
  
  
  ## Provide a method to set all team permissions from a hash
  def permissions=(hash)
    return if !hash.is_a?(Hash)
    self.listings_permissions = Permission.construct(hash[:listings])
    self.kpis_permissions     = Permission.construct(hash[:kpis])
    self.profile_permissions  = Permission.construct(hash[:profile])
    self.posts_permissions    = Permission.construct(hash[:posts])
    self.inbox_permissions    = Permission.construct(hash[:inbox])
  end
  
  
  
  ## Access Control
  # Checks if a team can be read by a certain user
  def can_be_read_by?(user, type_of_data)
    privacies = case type_of_data
    when :kpis
      kpis_privacies
    when :contact
      contact_privacies
    else
      []
    end
    
    privacies.include?('public') ||
    privacies.include?('communities') && (user.communities & communities).present? ||
    privacies.include?('connections') && (user.connections & users      ).present? ||
    privacies.include?('team')        && role_of(user) !== 'none'
  end
  
  # Checks if a team can be written by a certain user
  def can_be_written_by?(user, type_of_data)
    permissions = case type_of_data
    when :listings
      listings_permissions
    when :kpis
      kpis_permissions
    when :profile
      profile_permissions
    when :posts
      posts_permissions
    when :inbox
      inbox_permissions
    else
      []
    end
    
    permissions.include?(role_of(user).pluralize)
  end
  
  # Gets a user's role in the team
  def role_of(user)
    record = TeamMember.where(team: self, user: user).first
    record.present? ? record.role.name : 'none'
  end
end