# consider switching to rake task in the future: https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#linting-factories
require "rails_helper"
RSpec.describe "Factories" do
  it "lints successfully" do
    FactoryBot.lint
  end
end
