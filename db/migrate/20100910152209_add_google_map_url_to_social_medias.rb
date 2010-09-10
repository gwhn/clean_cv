class AddGoogleMapUrlToSocialMedias < ActiveRecord::Migration
  def self.up
    add_column :social_medias, :google_map_url, :string
  end

  def self.down
    remove_column :social_medias, :google_map_url
  end
end
