class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :roles

  has_many :people

  def role_symbols
    roles.map { |r| r.name.underscore.to_sym }
  end
end
