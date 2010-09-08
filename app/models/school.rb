class School < ActiveRecord::Base
  using_access_control

  validates_presence_of :name, :course, :date_from
  validates_uniqueness_of :name, :scope => :person_id
  validate :date_from_selected
  validate :date_from_prior_to_date_to

  belongs_to :person

  def stats
    first = person.first_school.date_from
    from = date_from
    to = date_to or Date.today
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
  def date_from_selected
    errors.add(:date_from, 'should be selected') if !date_from.selected?
  end

  def date_from_prior_to_date_to
    errors.add(:date_from, 'should be earlier than date to') if date_to.selected? && date_to < date_from
  end
end
