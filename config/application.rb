require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vagrant
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.action_mailer.delivery_method = :smtp # or :sendmail
    config.action_mailer.smtp_settings = {
        address:              'smtp.gmail.com',
        port:                 587,
        domain:               'gmail.com',
        user_name:            'smarttoolsg5',
        password:             'cloudAbcd!234',
        authentication:       'plain',
        enable_starttls_auto: true
    }
    config.aws_access = {
          access_key_id: Rails.application.secrets.aws_access_key_id,
          secret_access_key: Rails.application.secrets.aws_secret_access_key,
          region: Rails.application.secrets.aws_region
    }
   # ActionMailer::Base.default_content_type = "text/html"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
