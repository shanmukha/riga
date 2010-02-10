# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_riga_session',
  :secret      => '5fc57eda2d28aff681cec355aad03c8d5923fe58f82d22d45f2788c7ea3ea212b7b5999151401cafcee17b7e4cb15d174ce6c260d5b46272091b680731875f64'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
