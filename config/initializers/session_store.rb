# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_baby_names_session',
  :secret      => '88f3272dc7e37d86e20d17d8ed94a4e96bb516b1f36928c9eb999c2f6275fd375f501ba015407202df4fade3eb1f2fce2bf5aab5d84b528308129ed206a40efa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
