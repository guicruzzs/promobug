require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Promobug
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = 'Brasilia'
    config.i18n.default_locale = "pt-BR"
    config.encoding = "utf-8"

  end

  def self.settings
    @settings ||= YAML.load(File.open('config/promobug.yml'))[Rails.env]
  end
end
