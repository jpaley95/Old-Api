class Team < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",        null: false
  # t.string   "tagline"
  # t.string   "contact"
  # t.text     "summary"
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
  
  has_many :community_teams
  has_many :communities, through: :community_teams
  
  has_many :team_followers
  has_many :followers, through: :team_followers, source: :user
  
  has_and_belongs_to_many :listings_permissions, class_name: :Permission, join_table: :team_listings_permissions
  has_and_belongs_to_many :kpis_permissions,     class_name: :Permission, join_table: :team_kpis_permissions
  has_and_belongs_to_many :profile_permissions,  class_name: :Permission, join_table: :team_profile_permissions
  has_and_belongs_to_many :posts_permissions,    class_name: :Permission, join_table: :team_posts_permissions
  
  has_and_belongs_to_many :kpis_privacies,    class_name: :Privacy, join_table: :team_kpis_privacies
  has_and_belongs_to_many :contact_privacies, class_name: :Privacy, join_table: :team_contact_privacies
  
  has_and_belongs_to_many :industries, class_name: :Tag,  join_table: :industries
  
  has_many :kpis
  
  belongs_to :location
  
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Validation
  validates :name, presence: true
  
  
  
  ## Sectors
  def sectors
    sectors = []
    sectors.push 'commercial' if commercial
    sectors.push 'social'     if social
    sectors.push 'research'   if research
    sectors
  end
  
  
  
  ## Permission
  def permission
    {
      listings: listings_permissions.map(&:name),
      kpis:     kpis_permissions.map(&:name),
      profile:  profile_permissions.map(&:name),
      posts:    posts_permissions.map(&:name)
    }
  end
  
  
  
  ## Privacy
  def privacy
    {
      kpis:    kpis_privacies.map(&:name),
      contact: contact_privacies.map(&:name)
    }
  end
end