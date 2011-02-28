# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_assets_session',
  :secret      => '996e0f55da9170c0063a96c9a4bafb7bc9d564a38ba442eaa21d5a629870dda778c333d68b9f40f973e2915c99482cd37dc808a657f74422fd7d30a172ed445d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
