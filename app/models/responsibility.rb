class Responsibility < ActiveRecord::Base
  validates_presence_of :description, :company_id

  belongs_to :company
end
