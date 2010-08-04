class AddPositionToSkills < ActiveRecord::Migration
  def self.up
    add_column :skills, :position, :integer
  end

  def self.down
    remove_column :skills, :position
  end
end
