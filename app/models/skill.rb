class Skill < ActiveRecord::Base
  validates_presence_of :name, :level, :description, :person_id
  validates_uniqueness_of :name

  belongs_to :person

  acts_as_list :scope => :person

  default_scope 'position'
end
