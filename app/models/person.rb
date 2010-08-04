class Person < ActiveRecord::Base
  validates_presence_of :name, :job_title, :email, :phone, :mobile,
                        :portrait_url, :portrait_thumb_url, :profile
  validates_uniqueness_of :name, :email
  validates_format_of :portrait_url, :with => %r{\.(gif|jpg|png)$}i,
                      :message => 'must be a URL for GIF, JPG or PNG image'

  has_many :companies, :dependent => :destroy, :order => 'start_date DESC'
  has_many :skills, :dependent => :destroy
  has_many :schools, :dependent => :destroy, :order => 'date_from DESC'

  has_attached_file :photo, :styles => {:small => '100x100#'}

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  def to_param
    "#{id}-#{name.parameterize}"
  end

end
