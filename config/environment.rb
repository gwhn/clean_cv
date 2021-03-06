# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  config.load_paths += %W(#{RAILS_ROOT}/app/sweepers)

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "rack", :version => "~> 1.0.1"
  config.gem "warden"
  config.gem "devise", :version => "~> 1.0.8"
  config.gem "haml"
  config.gem "formtastic"
  config.gem "validation_reflection"
  config.gem "paperclip"
  config.gem "responds_to_parent"
  config.gem "acts_as_list"
  config.gem "acts_as_tree"
  config.gem "will_paginate"
  config.gem "declarative_authorization"
  config.gem "machinist"
  config.gem "faker"
  config.gem "mocha"
  config.gem "timecop"
  config.gem "compass"
  config.gem "pdfkit"
  config.gem "babosa", :version => "~> 0.2.0"
  config.gem "friendly_id", :version => "~> 3.1.3"
  config.gem "seer"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :cv_sweeper

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  config.action_mailer.smtp_settings = {
          :address => 'mail.weblitz.co.uk',
          :port  => 25,
          :domain  => 'weblitz.co.uk',
          :authentication => :login,
          :user_name => 'cv@weblitz.co.uk',
          :password => 'banarama'
  }

  require 'pdfkit'
  config.middleware.use PDFKit::Middleware

  require 'selectable_date'

end