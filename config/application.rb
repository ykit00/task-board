require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module TaskBoard
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'Tokyo'

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: false
    end
  end
end
