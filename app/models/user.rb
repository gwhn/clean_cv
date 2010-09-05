class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable
  devise :registerable, :database_authenticatable, :confirmable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable, :timeoutable, :activatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  has_and_belongs_to_many :roles

  has_many :people

  after_create do |record|
    record.roles << Role.find_by_name('Admin') if User.count == 1
    record.roles << Role.find_by_name('User')
  end

  def role_symbols
    roles.map { |r| r.name.underscore.to_sym }
  end
end
