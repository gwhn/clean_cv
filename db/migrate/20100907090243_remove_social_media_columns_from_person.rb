class RemoveSocialMediaColumnsFromPerson < ActiveRecord::Migration
  def self.up
    Person.all.each do |p|
      SocialMedia.create :person_id => p.id,
                         :linked_in_url => p.linked_in_url,
                         :facebook_url => p.facebook_url,
                         :twitter_url => p.twitter_url,
                         :flickr_url => p.flickr_url
    end
    remove_column :people, :linked_in_url
    remove_column :people, :facebook_url
    remove_column :people, :twitter_url
    remove_column :people, :flickr_url
  end

  def self.down
    add_column :people, :flickr_url, :string
    add_column :people, :twitter_url, :string
    add_column :people, :facebook_url, :string
    add_column :people, :linked_in_url, :string
    SocialMedia.all.each do |sm|
      Person.update sm.person.id,
                    :linked_in_url => sm.linked_in_url,
                    :facebook_url => sm.facebook_url,
                    :twitter_url => sm.twitter_url,
                    :flickr_url => sm.flickr_url
    end
  end
end
