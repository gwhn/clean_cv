# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cv_session',
  :secret      => '212b38908bea1154f84a39ff6d282007a2eccbb7d7ea943cd3b9944fcbe76c218191f8838dbe4cbaafeb00e4eede92bc93ad656073240c3ec15b381ab0f5799d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
