class AddSocialMediaUrlsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :flickr_url, :string
    add_column :people, :twitter_url, :string
    add_column :people, :facebook_url, :string
    add_column :people, :linked_in_url, :string
  end

  def self.down
    remove_column :people, :linked_in_url
    remove_column :people, :facebook_url
    remove_column :people, :twitter_url
    remove_column :people, :flickr_url
  end
end
