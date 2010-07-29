class Task < ActiveRecord::Base
  validates_presence_of :description, :project_id

  belongs_to :project
end
