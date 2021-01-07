class DemoSessionsController < ApplicationController
  def show
    @demo_session = authorize(current_user.demo_sessions.find(params['id']))
  end

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
end
