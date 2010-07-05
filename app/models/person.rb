class Person < ActiveRecord::Base
  validates_presence_of :name, :job_title, :email, :phone, :mobile, :portrait_url, :profile
  validates_uniqueness_of :name, :email
  validates_format_of :portrait_url, :with => %r{\.(gif|jpg|png)$}i,
                      :message => 'must be a URL for GIF, JPG or PNG image'

  has_many :companies
  has_many :skills
  has_many :schools
end
