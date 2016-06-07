# frozen_string_literal: true
# code: config/environments/development.rb
# test: spec/config/ : assigned kathyonu : 20160416
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send? Use false
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  # config.assets.debug = false
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all
  # assets, yet still be able to expire them through the digest params.
  # ref : http://edgeguides.rubyonrails.org/4_2_release_notes.html
  #
  # http://guides.rubyonrails.org/asset_pipeline.html
  # The fingerprinting behavior is controlled by the
  # config.assets.digest initialization option (which defaults to
  # true for production and false for development and testing.
  # Under normal circumstances the default config.assets.digest option
  # should not be changed.
  config.assets.digest = false

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations : also in test.rb
  # TODO: Research how this command works, then uncomment as need be
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp

  # TODO: Research this command, and when writing email tests
  # Ref: http://guides.rubyonrails.org/action_mailer_basics.html
  config.action_mailer.perform_deliveries = true

  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'],
    authentication: 'login',
    port: 587,
    domain: ENV['SMTP_DOMAIN'],
    enable_starttls_auto: true,
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD']
  }

  # Paperclip config
  config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {
      bucket: 'visitmeet',
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
end
