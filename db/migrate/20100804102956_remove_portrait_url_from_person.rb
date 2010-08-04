class RemovePortraitUrlFromPerson < ActiveRecord::Migration
  def self.up
    remove_column :people, :portrait_url
    remove_column :people, :portrait_thumb_url
  end

  def self.down
    add_column :people, :portrait_url, :string
    add_column :people, :portrait_thumb_url, :string
  end
end
