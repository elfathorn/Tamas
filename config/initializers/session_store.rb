# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Tamas_session',
  :secret      => '8229a810050242ebace4621fbad85d16f4ab7828a82810fa83af00572ad39ffee392a9abdc6f7d3fd42ed3b47b88f4e2d84ff9cc0d23633311afdb19e704b3bb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
