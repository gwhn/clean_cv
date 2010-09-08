class Category < ActiveRecord::Base
  acts_as_tree :order => :name

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :parent_id

  has_many :skills
end
