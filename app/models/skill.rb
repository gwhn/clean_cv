class Skill < ActiveRecord::Base
  validates_presence_of :name, :level, :description
  validates_uniqueness_of :name
end
