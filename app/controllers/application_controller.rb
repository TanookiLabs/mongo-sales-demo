class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit
  before_action :set_raven_context
  before_action :authenticate_user!, unless: :devise_controller?

  after_action :verify_authorized, except: :index, unless: -> { devise_controller? }
  after_action :verify_policy_scoped, only: :index, unless: -> { devise_controller? }

  private

  def authenticate_admin!
    redirect_to root_path unless current_user&.superuser?
    current_user
  end

  def set_raven_context
    Raven.user_context(id: current_user.id) if current_user
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
