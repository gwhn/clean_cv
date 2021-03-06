class Company < ActiveRecord::Base
  using_access_control

  validates_presence_of :name, :role, :business_type, :start_date
  validates_uniqueness_of :name, :scope => :person_id
  validate :start_date_selected
  validate :start_date_prior_to_end_date

  belongs_to :person
  has_many :projects, :dependent => :destroy, :order => :position
  has_many :responsibilities, :dependent => :destroy, :order => :position

  validates_associated :projects, :responsibilities
  accepts_nested_attributes_for :projects, :responsibilities,
                                :allow_destroy => true,
                                :reject_if => lambda { |a| a.values.all?(& :blank?) }

  def stats
    first = person.first_company.start_date
    from = start_date
    to = end_date or Date.today
    (first.year..to.year).map do |year|
      if year == from.year and year == to.year
        months = (to.month - from.month)
      elsif year == from.year
        months = 12 - from.month
      elsif year == to.year
        months = to.month
      elsif year >= from.year and year <= to.year
        months = 12
      else
        months = 0
      end
      Statistic.new year, months
    end
  end

  protected
  def start_date_selected
    errors.add(:start_date, 'should be selected') if !start_date.selected?
  end

  def start_date_prior_to_end_date
    errors.add(:start_date, 'should be earlier than end date') if end_date.selected? and end_date < start_date
  end
end

