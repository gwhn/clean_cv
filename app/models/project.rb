class Project < ActiveRecord::Base
  validates_presence_of :name, :description, :company_id
  validates_uniqueness_of :name
  validates_associated :responsibilities

  belongs_to :company
  has_many :responsibilities

  def new_responsibility_attributes=(attributes)
    attributes.each do |a|
      responsibilities.build(a)
    end
  end

  def existing_responsibility_attributes=(attributes)
    responsibilities.reject(&:new_record?).each do |r|
      attr = attributes[r.id.to_s]
      if attr
        r.attributes = attr
      else
        responsibilities.destroy(r)
      end
    end
  end

  after_update :save_responsibilities

  def save_responsibilities
    responsibilities.each do |r|
      r.save(false)
    end
  end
end
