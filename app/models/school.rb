class School < ActiveRecord::Base
  using_access_control

  validates_presence_of :name, :course, :date_from
  validates_uniqueness_of :name, :scope => :person_id
  validate :date_from_selected
  validate :date_from_prior_to_date_to

  belongs_to :person

  protected
  def date_from_selected
    errors.add(:date_from, 'should be selected') if !date_from.selected?
  end

  def date_from_prior_to_date_to
    errors.add(:date_from, 'should be earlier than date to') if date_to.selected? && date_to < date_from
  end
  
end
