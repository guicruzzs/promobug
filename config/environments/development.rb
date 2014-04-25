Promobug::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # variaveis globais para o google
  URL_BASE = "http://crosspromobug.herokuapp.com/google_login_response"
  URL_GOOGLE_OAUTH = "https://accounts.google.com/o/oauth2/"
  URL_GOOGLE_API = "https://www.googleapis.com/"
  URL_GOOGLE_CALENDAR = URL_GOOGLE_API + "calendar/v3/"
  CLIENT_ID = '342833357798-tirkltmccr2dhdbea1curhpcain7aurj.apps.googleusercontent.com'
  GOOGLE_CLIENT_SECRET = 'CoDt1nhyhck8RMviMQxQ29F7'
  
  GOOGLE_API_KEY = "AIzaSyBFheU3FLhas3JYYUcVu2Z9fvKleKuZKvA"
  # variaveis globais para o sistema
  CRYPT_KEY = "b678ijbvft6uir56ujft67i78oqoiu212013hfwdo0"

  RELEASE_CODE ="a89kjh324kj234k09fddf0s8j234kia"
end

