class Project < ActiveRecord::Base
  validates_presence_of :name, :description
  validates_uniqueness_of :name
  validates_associated :tasks

  belongs_to :company
  has_many :tasks, :dependent => :destroy, :order => :position
  has_and_belongs_to_many :skills

  accepts_nested_attributes_for :tasks,
                                :allow_destroy => true,
                                :reject_if => lambda { |a| a.values.all?(& :blank?) }
end
