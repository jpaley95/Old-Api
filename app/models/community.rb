class Community < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",                     null: false
  # t.string   "headline"
  # t.string   "video"
  # t.string   "domains"
  # t.text     "policy"
  # t.text     "description"
  # t.string   "website"
  # t.string   "facebook"
  # t.string   "twitter"
  # t.string   "linkedin"
  # t.date     "founded_at"
  # t.datetime "archived_at"
  # t.integer  "category",                 null: false
  # t.integer  "profile_permission_id",    null: false
  # t.integer  "members_permission_id",    null: false
  # t.integer  "children_permission_id",   null: false
  # t.integer  "statistics_permission_id", null: false
  # t.integer  "posts_permission_id",      null: false
  # t.integer  "listings_permission_id",   null: false
  # t.integer  "resources_permission_id",  null: false
  # t.integer  "events_permission_id",     null: false
  # t.integer  "events_privacy_id",        null: false
  # t.integer  "resources_privacy_id",     null: false
  # t.integer  "location_id"
  # t.integer  "community_id"
  # t.datetime "created_at",               null: false
  # t.datetime "updated_at",               null: false
  
  
  
  ## Actable (MTI)
  acts_as :handle
  
  
  
  ## Relationships
  has_many :resources
  has_many :categories, through: :resources
  
  belongs_to :parent,   class_name: :Community
  has_many   :children, class_name: :Community, dependent: :restrict_with_exception
  
  has_many :members, class_name: :CommunityMember
  has_many :users, through: :members
  
  has_and_belongs_to_many :teams, join_table: :community_teams
  
  belongs_to :location, autosave: true, dependent: :destroy
  
  belongs_to :profile_permission,    class_name: :Permission
  belongs_to :members_permission,    class_name: :Permission
  belongs_to :children_permission,   class_name: :Permission
  belongs_to :statistics_permission, class_name: :Permission
  belongs_to :posts_permission,      class_name: :Permission
  belongs_to :listings_permission,   class_name: :Permission
  belongs_to :resources_permission,  class_name: :Permission
  belongs_to :events_permission,     class_name: :Permission
  
  belongs_to :events_privacy,    class_name: :Privacy
  belongs_to :resources_privacy, class_name: :Privacy
  
  has_one :logo,   class_name: :Image, as: :owner
  has_one :avatar, class_name: :Image, as: :owner
  
  
  
  ## Validation
  validates :name, presence: true
  
  
  
  ## Enumerations
  enum category: [
    :university,
    :space,
    :organization,
    :other
  ]
  
  
  
  ## Alias
  alias_attribute :signup_mode, :domains
  
  
  
  ## Scopes
  def self.roots
    self.where     community_id: nil
  end
  def self.leafs
    self.where.not community_id: nil
  end
  def self.active
    self.where     archived_at:  nil
  end
  def self.archived
    self.where.not archived_at:  nil
  end
  
  
  
  ## Tree Traversal
  # Traverse up the community tree for the root community
  def root
    if parent.nil?
    then self
    else parent.root
    end
  end
  
  # Traverse up the community tree for the nearest photo/description
  def closest_photo
    if photo.exists? || parent.nil?
    then photo
    else parent.closest_photo
    end
  end
  def closest_description
    if !description.blank? || parent.nil?
    then description
    else parent.closest_description
    end
  end
  
  # Traverse the community tree to see if another community is related to the
  #   current community
  def is_ancestor_of?(community)
    self == community || community.parent.present? && is_ancestor_of?(community.parent)
  end
  def is_descendent_of?(community)
    community.is_ancestor_of?(self)
  end
  
  
  
  ## Provide a method to set all community privacies from a hash
  def privacy=(hash)
    return if !hash.is_a?(Hash)
    self.events_privacy    = Privacy.construct(hash[:events]).first
    self.resources_privacy = Privacy.construct(hash[:resources]).first
  end
  
  
  
  ## Provide a method to set all community permissions from a hash
  def permissions=(hash)
    return if !hash.is_a?(Hash)
    self.profile_permission    = Permission.construct(hash[:profile]).first
    self.members_permission    = Permission.construct(hash[:members]).first
    self.children_permission   = Permission.construct(hash[:children]).first
    self.statistics_permission = Permission.construct(hash[:statistics]).first
    self.posts_permission      = Permission.construct(hash[:posts]).first
    self.listings_permission   = Permission.construct(hash[:listings]).first
    self.resources_permission  = Permission.construct(hash[:resources]).first
    self.events_permission     = Permission.construct(hash[:events]).first
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
  
  
  
  ## Access Control
  # Checks if a community can be read by a certain user
  def can_be_read_by?(user, type_of_data)
    privacy = [type_of_data, 'privacy'].compact.join('_').send
    privacy.name === 'public' || role_of(user) !== 'none'
  end
  
  # Checks if a community can be written by a certain user
  def can_be_written_by?(user, type_of_data)
    permission = [type_of_data, 'permission'].compact.join('_').send
    roles = ['owner', 'administrator', 'member']
    roles.slice!(0, roles.find_index(permission.name.singularize) + 1)
    roles.include?(role_of(user))
  end
  
  # Gets a user's role in the community
  def role_of(user)
    record = CommunityMember.where(community: self, user: user).first
    record.present? ? record.role.name : 'none'
  end
end