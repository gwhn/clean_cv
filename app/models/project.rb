class Project < ActiveRecord::Base
  validates_presence_of :name, :description
  validates_uniqueness_of :name

  belongs_to :company
  has_many :responsibilities
end
