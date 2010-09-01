class Person < ActiveRecord::Base
  using_access_control

  has_friendly_id :name, :use_slug => true
  
  validates_presence_of :name, :job_title, :email, :phone, :mobile, :profile, :user
  validates_uniqueness_of :name, :email
  validates_format_of :flickr_url, :twitter_url, :facebook_url, :linked_in_url,
                      :with => %r{\A(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?������]))\Z}i,
                      :allow_blank => true
  validates_format_of :email, :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i

  has_many :companies, :dependent => :destroy, :order => 'start_date DESC'
  has_many :skills, :dependent => :destroy, :order => :position
  has_many :schools, :dependent => :destroy, :order => 'date_from DESC'

  validates_associated :companies, :skills, :schools
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
                                          a['date_to(2i)'] == '1' and
                                          a['date_to(3i)'] == '1' and
                                          a['date_from(2i)'] == '1' and
                                          a['date_from(3i)'] == '1'
                                }

  has_attached_file :photo, :styles => {:small => '100x100#'}

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  belongs_to :user
end
