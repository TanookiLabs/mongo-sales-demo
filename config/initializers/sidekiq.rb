sidekiq_concurrency_num = (ENV["SIDEKIQ_CONCURRENCY"] || 5).to_i

Sidekiq.configure_server do |config|
  config.redis = { namespace: "mongo-salesdemo" }

  if defined?(ActiveRecord::Base)
    spec = "#{Rails.env}_sidekiq" # For separate db pool configuration
    if Rails.application.config.database_configuration.key?(spec)
      ActiveRecord::Base.establish_connection(spec.to_sym)
    else
      ActiveRecord::Base.establish_connection
    end
    Rails.logger.info("Connected to ActiveRecord in Sidekiq")
  end
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: "mongo-salesdemo" }
end

Sidekiq.options[:concurrency] = sidekiq_concurrency_num
Sidekiq.default_worker_options = { "backtrace" => true }
