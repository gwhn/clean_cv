class Person < ActiveRecord::Base
  validates_presence_of :name, :job_title, :email, :phone, :mobile, :profile
  validates_uniqueness_of :name, :email

  has_many :companies, :dependent => :destroy, :order => 'start_date DESC'
  has_many :skills, :dependent => :destroy, :order => :position
  has_many :schools, :dependent => :destroy, :order => 'date_from DESC'

  has_attached_file :photo, :styles => {:small => '100x100#'}

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
