# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_create_by_rails_session',
  :secret      => 'c6f7d583ad5f5556bb43361408c802b5c8f2d76f8df589476cede6b2a6ef2b4e7ac914292fc46cdd29e6ad94076407cb3ad7099bac59860badd2b16589f7a7dd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
