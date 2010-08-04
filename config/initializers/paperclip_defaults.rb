module Paperclip
  class Attachment
    def self.default_options
      @default_options ||= {
              :url           => "/system/:class/:attachment/:id/:style/:basename.:extension",
              :path          => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
              :styles            => {},
              :processors        => [:thumbnail],
              :convert_options   => {},
              :default_url       => "/:attachment/:style/missing.jpg",
              :default_style     => :original,
              :storage           => :filesystem,
              :whiny             => Paperclip.options[:whiny] || Paperclip.options[:whiny_thumbnails]
      }
    end
  end
end

