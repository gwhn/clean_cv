class SocialMedia < ActiveRecord::Base
  using_access_control

  validates_format_of :flickr_url, :twitter_url, :facebook_url, :linked_in_url, :google_map_url,
                      :with => %r{\A(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?гхрсту]))\Z}i,
                      :allow_blank => true
  
  belongs_to :person
end
