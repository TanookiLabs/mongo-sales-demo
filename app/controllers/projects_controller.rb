class ProjectsController < ApplicationController
  def index
    @projects = policy_scope(Project)
  end

  def show
    @project = authorize(Project.find(params['id']))
    @demo_session = @project.demo_sessions.active.where(user: current_user).first
  end
end
