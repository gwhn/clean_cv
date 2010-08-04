class Task < ActiveRecord::Base
  validates_presence_of :description

  belongs_to :project

  acts_as_list :scope => :project

  default_scope 'position'
end
