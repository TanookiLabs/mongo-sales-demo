class ApplicationController < ActionController::Base
  before_action :set_raven_context

  private

  def set_raven_context
    # Uncomment when user is setup:
    # Raven.user_context(id: current_user.id) if current_user
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
