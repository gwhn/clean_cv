class Responsibility < ActiveRecord::Base
  validates_presence_of :description, :company_id

  belongs_to :company

  acts_as_list :scope => :company

  default_scope 'position'
end
