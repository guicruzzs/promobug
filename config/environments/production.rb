Promobug::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # variaveis globais para o google
  URL_BASE = "http://crosspromobug.herokuapp.com/google_login_response"
  URL_GOOGLE_OAUTH = "https://accounts.google.com/o/oauth2/auth"
  URL_GOOGLE_API = "https://www.googleapis.com/"
  URL_GOOGLE_CALENDAR = URL_GOOGLE_API + "calendar/v3/"
  CLIENT_ID = '342833357798-tirkltmccr2dhdbea1curhpcain7aurj.apps.googleusercontent.com'
  GOOGLE_CLIENT_SECRET = 'CoDt1nhyhck8RMviMQxQ29F7'

  GOOGLE_API_KEY = "AIzaSyBFheU3FLhas3JYYUcVu2Z9fvKleKuZKvA"
  # variaveis globais para o sistema
  CRYPT_KEY = "b678ijbvft6uir56ujft67i78oqoiu212013hfwdo0"
end
