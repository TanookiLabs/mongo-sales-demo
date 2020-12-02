Rails.application.config.generators do |g|
  # use UUIDs by default
  g.orm :active_record, primary_key_type: :uuid

  # limit default generation
  g.test_framework(
    :rspec,
    fixtures: true,
    view_specs: false,
    controller_specs: false,
    routing_specs: false,
    request_specs: false,
  )

  # prevent generating js/css/helper files
  g.assets false
  g.helper false

  g.fixture_replacement :factory_bot, dir: "spec/factories"
  g.factory_bot suffix: "factory"
end
