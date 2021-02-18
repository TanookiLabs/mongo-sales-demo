require "selenium/webdriver"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  # https://github.com/teamcapybara/capybara/blob/master/lib/capybara/registrations/drivers.rb
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--headless'
    opts.args << '--disable-gpu' if Gem.win_platform?
    # Workaround https://bugs.chromium.org/p/chromedriver/issues/detail?id=2650&q=load&sort=-id&colspec=ID%20Status%20Pri%20Owner%20Summary
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--window-size=1024,768'
  end

  # https://github.com/heroku/heroku-buildpack-google-chrome#selenium
  chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
  chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)

  Capybara::Selenium::Driver.new app, browser: :chrome, desired_capabilities: capabilities, options: browser_options
end


Capybara.javascript_driver = :headless_chrome
