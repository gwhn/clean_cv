class School < ActiveRecord::Base
  validates_presence_of :name, :course, :result, :date_from
  validates_uniqueness_of :name
  validate :date_from_prior_to_date_to

  protected
  def date_from_prior_to_date_to
    errors.add(:date_from, 'should be earlier than date to') if !date_to.nil? && date_to < date_from
  end
end
