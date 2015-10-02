class Education < ActiveRecord::Base
  # Database Fields
  # t.integer  "school_id",   null: false
  # t.integer  "degree_id"
  # t.date     "started_at"
  # t.date     "finished_at"
  # t.text     "grades"
  # t.text     "activities"
  # t.text     "classes"
  # t.text     "honors"
  # t.text     "description"
  # t.integer  "user_id",     null: false
  # t.datetime "created_at",  null: false
  # t.datetime "updated_at",  null: false
  
  
  # Relationships
  belongs_to :user
  belongs_to :school
  belongs_to :degree
  has_and_belongs_to_many :majors, class_name: :Field, join_table: :majors
  has_and_belongs_to_many :minors, class_name: :Field, join_table: :minors
  
  
  # Validation
  validates :user,   presence: true
  validates :degree, presence: true
end
