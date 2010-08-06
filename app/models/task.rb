class Task < ActiveRecord::Base
  using_access_control

  validates_presence_of :description

  belongs_to :project

  acts_as_list :scope => :project

  default_scope :order => :position
end
