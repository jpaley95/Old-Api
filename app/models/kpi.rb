class Kpi < ActiveRecord::Base
  ## Database Fields
  # t.string   "name",                         null: false
  # t.text     "details"
  # t.boolean  "is_completed", default: false, null: false
  # t.datetime "started_at"
  # t.datetime "finished_at"
  # t.integer  "team_id",                      null: false
  # t.datetime "created_at",                   null: false
  # t.datetime "updated_at",                   null: false
  
  
  
  ## Relationships
  belongs_to :team
  has_many :success_metrics
  
  
  
  ## Validation
  validates :name,         presence: true
  validates :is_completed, presence: true
  validates :team,         presence: true
  
  
  
  ## Alias
  alias_attribute :completed, :is_completed
end
