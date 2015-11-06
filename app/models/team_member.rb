class TeamMember < ActiveRecord::Base
  # Database Fields
  # t.integer  "user_id",    null: false
  # t.integer  "team_id",    null: false
  # t.integer  "role_id",    null: false
  # t.string   "title"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  
  
  ## Relationships
  belongs_to :user
  belongs_to :role
  belongs_to :team
  
  
  ## Validation
  validates :user, presence: true
  validates :role, presence: true
  validates :team, presence: true
  validate :role_must_be_in_whitelist
  
  
  ## Custom validation for role
  def self.role_whitelist
    ['founder', 'leader', 'teammate',
     'freelancer', 'intern',
     'board', 'investor', 'mentor']
  end
  def role_must_be_in_whitelist
    unless self.role_whitelist.include? role.name
      errors.add(:role, 'must be one of the following: "' + self.role_whitelist.join('", "') + '"')
    end
  end
  
  
  ## Intercept role setter
  def role=(role)
    super(Role.construct role)
  end
end
