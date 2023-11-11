require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

# Add the following line to include the rack-cors gem
require "rack/cors"

Bundler.require(*Rails.groups)

module MakawascoBackend
  class Application < Rails::Application
    config.load_defaults 7.0

    # CORS configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3000', 'https://sokoapi.onrender.com'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
      end
    end

    config.generators.system_tests = nil
  end
end