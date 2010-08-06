class Person < ActiveRecord::Base
  using_access_control

  validates_presence_of :name, :job_title, :email, :phone, :mobile, :profile, :user
  validates_uniqueness_of :name, :email
  validates_format_of :flickr_url, :twitter_url, :facebook_url, :linked_in_url,
                      :with => %r{\A(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?гхрсту]))\Z}i,
                      :allow_blank => true
  validates_format_of :email, :with => %r{/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i

  has_many :companies, :dependent => :destroy, :order => 'start_date DESC'
  has_many :skills, :dependent => :destroy, :order => :position
  has_many :schools, :dependent => :destroy, :order => 'date_from DESC'

  has_attached_file :photo, :styles => {:small => '100x100#'}

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  belongs_to :user
  
  def to_param
    "#{id}-#{name.parameterize}"
  end

end
