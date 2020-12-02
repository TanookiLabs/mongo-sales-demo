Raven.configure do |config|
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)

  # consider async reporting: https://github.com/getsentry/raven-ruby#async

  # config.transport_failure_callback = lambda { |event|
  #   AdminMailer.email_admins("Oh god, it's on fire!", event).deliver_later
  # }
end
