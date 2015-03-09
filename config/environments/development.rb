Splendor::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.js_compressor = :uglifier

  # Expands the lines which load the assets
  config.assets.debug = true

  # Mailer settings
  # don't bother
  config.action_mailer.perform_deliveries = false 

  config.eager_load = false
end
