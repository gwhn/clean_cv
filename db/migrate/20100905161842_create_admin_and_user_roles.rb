class CreateAdminAndUserRoles < ActiveRecord::Migration
  def self.up
    user_role = nil
    ['Admin', 'User'].each{|r| user_role = Role.find_or_create_by_name r}
    User.all.each do |u|
      u.roles << user_role unless u.roles.detect{|r| r == user_role}
    end
  end

  def self.down
  end
end
