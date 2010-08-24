class Responsibility < ActiveRecord::Base
  using_access_control

  validates_presence_of :description
  validates_uniqueness_of :description, :scope => :company_id

  belongs_to :company

  acts_as_list :scope => :company

  default_scope :order => :position
end
