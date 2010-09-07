class CreateSocialMedias < ActiveRecord::Migration
  def self.up
    create_table :social_medias do |t|
      t.integer :person_id, :null => false
      t.string :linked_in_url
      t.string :facebook_url
      t.string :twitter_url
      t.string :flickr_url

      t.timestamps
    end
  end

  def self.down
    drop_table :social_medias
  end
end
