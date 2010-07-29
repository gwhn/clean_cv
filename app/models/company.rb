class Company < ActiveRecord::Base
  validates_presence_of :name, :role, :business_type, :start_date, :person_id
  validate :start_date_prior_to_end_date
  validates_associated :projects, :responsibilities

  belongs_to :person
  has_many :projects, :dependent => :destroy
  has_many :responsibilities, :dependent => :destroy

  accepts_nested_attributes_for :projects, :responsibilities,
                                :allow_destroy => true,
                                :reject_if => lambda { |a| a.values.all?(& :blank?) }

  protected
  def start_date_prior_to_end_date
    errors.add(:start_date, 'should be earlier than end date') if !end_date.nil? && end_date < start_date
  end

end
