module Admin
  class ProjectsController < BaseController
    def index
      @projects = policy_scope(Project)
    end

    def show
      @project = policy_scope(Project).find(params['id'])
      authorize(@project)
    end
  end
end
