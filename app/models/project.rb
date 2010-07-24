class Project < ActiveRecord::Base
  validates_presence_of :name, :description, :company_id
  validates_uniqueness_of :name

  belongs_to :company
end
