require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wera
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # create a db specific dump in structure.sql file rather than schema.rb. IIRC when :sql is set rails test code loads that instead of the schema.rb
    # config.active_record.schema_format = :sql
    config.time_zone = 'Nairobi'


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
