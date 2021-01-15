class DemoSessionsController < ApplicationController
  before_action :set_demo_session, except: [:complete]

  def show; end

  def complete
    @project = Project.find(params['id'])
    @demo_session = current_user.demo_sessions.active.where(project: @project).first
    if @demo_session
      authorize(@demo_session, :update?)
      @demo_session.update(ended_at: DateTime.now)
      redirect_to demo_session_path(@demo_session)
    else
      skip_authorization
      redirect_to root_path
    end
  end

  def email
    UserMailer.session_notes(@demo_session).deliver_later
    flash[:notice] = "Session notes sent to #{current_user.email}"
    redirect_to demo_session_path(@demo_session)
  end

  private

  def set_demo_session
    @demo_session = authorize(current_user.demo_sessions.find(params['id']))
  end
end
