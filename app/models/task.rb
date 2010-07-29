class Task < ActiveRecord::Base
  validates_presence_of :description

  belongs_to :project
end
