class AddPortraitThumbUrlToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :portrait_thumb_url, :string
  end

  def self.down
    remove_column :people, :portrait_thumb_url
  end
end
