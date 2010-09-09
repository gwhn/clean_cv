class Person < ActiveRecord::Base
  using_access_control

  belongs_to :user

  has_friendly_id :name, :use_slug => true

  validates_presence_of :name, :job_title, :email, :phone, :mobile, :profile, :user
  validates_uniqueness_of :name, :email
  validates_format_of :email, :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i

  has_many :companies, :dependent => :destroy, :order => 'start_date DESC'
  has_many :skills, :dependent => :destroy, :order => :position
  has_many :schools, :dependent => :destroy, :order => 'date_from DESC'

  has_one :social_media, :dependent => :destroy

  validates_associated :companies, :skills, :schools, :social_media

  accepts_nested_attributes_for :social_media

  accepts_nested_attributes_for :companies,
                                :allow_destroy => true,
                                :reject_if => lambda { |a|
                                  a['name'].blank? and
                                          a['role'].blank? and
                                          a['business_type'].blank? and
                                          a['start_date(3i)'] == '1' and
                                          a['end_date(3i)'] == '1'
                                }

  accepts_nested_attributes_for :skills,
                                :allow_destroy => true,
                                :reject_if => lambda { |a| a.values.all?(& :blank?) }

  accepts_nested_attributes_for :schools,
                                :allow_destroy => true,
                                :reject_if => lambda { |a|
                                  a['name'].blank? and
                                          a['course'].blank? and
                                          a['date_to(3i)'] == '1' and
                                          a['date_from(3i)'] == '1'
                                }

  has_attached_file :photo, :styles => {:small => '100x100#'}

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def skills_by_category
    categories = Hash.new { |h, k| h[k] = [] }
    skills.each { |s| categories[s.category.name] << s }
    categories
  end

  def first_company
    companies.sort{|a, b| a.start_date <=> b.start_date}.first
  end

  def first_school
    schools.sort{|a, b| a.date_from <=> b.date_from}.first
  end
end
