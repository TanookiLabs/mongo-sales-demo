module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: [:edit, :update, :duplicate, :destroy]
    def index
      @projects = policy_scope(Project)
    end

    def new
      @project = authorize(Project.new)
    end

    def create
      @project = authorize(Project.new(permitted_attributes(Project)))
      if @project.save
        flash[:notice] = 'Project created.'
        redirect_to edit_admin_project_path(@project)
      else
        render :new
      end
    end

    def edit; end

    def update
      @project.assign_attributes(permitted_attributes(Project))
      if @project.save
        flash[:notice] = 'Project updated.'
        redirect_to edit_admin_project_path(@project)
      else
        render :edit
      end
    end

    def destroy
      @project.destroy!
      flash[:notice] = 'Project successfully deleted.'
      redirect_to admin_projects_path
    end

    def duplicate
      new_project = @project.deep_clone(include: { screens: [:links, :sales_items] })
      new_project.title = @project.title + ' (Copy)'
      new_project.save!
      flash[:notice] = 'Project successfully duplicated.'
      redirect_to edit_admin_project_path(new_project)
    end

    private

    def set_project
      @project = authorize(policy_scope(Project).find(params['id']))
    end
  end
end
