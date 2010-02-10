# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false
config.action_mailer.default_url_options = { :host => "localhost:3000"}

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  paypal_options = {:login => "vijendrakarkala_api1.gmail.com",
                     :password => "CP2PB2Q7LZU8BB6B",
                     :signature => "AODF0BcpZfadW.tUxelxhSjzCwgcADfk8jVrWkOPTK.nYnoRAi3LrgHP"
                    }

  ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
  ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
end
