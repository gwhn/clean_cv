class AddPositionToResponsibilities < ActiveRecord::Migration
  def self.up
    add_column :responsibilities, :position, :integer
  end

  def self.down
    remove_column :responsibilities, :position
  end
end
