class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_raven_context
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def set_raven_context
    # Uncomment when user is setup:
    # Raven.user_context(id: current_user.id) if current_user
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
