class Skill < ActiveRecord::Base
  using_access_control

  validates_presence_of :name, :level, :description
  validates_uniqueness_of :name, :scope => :person_id

  belongs_to :person
  has_and_belongs_to_many :projects, :readonly => true  

  acts_as_list :scope => :person

  default_scope :order => :position
end
