module Admin
  class ScreensController < BaseController
    before_action :set_screen

    def new; end

    def create
      update_and_save!
    end

    def edit; end

    def update
      update_and_save!
    end

    def destroy
      @screen.destroy!
      redirect_to admin_project_path(@screen.project)
    end

    private

    def set_project
      @project = policy_scope(Project).find(params['project_id'])
    end

    def set_screen
      @screen = params['id'].present? ? Screen.find(params['id']) : policy_scope(Project).find(params['project_id']).screens.build
      authorize(@screen)
    end

    def update_and_save!
      @screen.assign_attributes(permitted_attributes(Screen))

      @screen.sales_items.each do |sales_item|
        next if sales_item.marked_for_destruction?
        @screen.sales_items.delete(sales_item) if sales_item.content.blank?
      end

      if @screen.valid?
        ActiveRecord::Base.transaction do
          @screen.save!
          @screen.project.screens.where.not(id: @screen.id).update_all(root: false) if @screen.root?
        end
        flash[:notice] = "Screen '#{@screen.title}' #{action_name == 'update' ? 'updated' : 'created'}."
        redirect_to edit_admin_project_path(@screen.project)
      else
        render @screen.persisted? ? :edit : :new
      end
    end
  end
end
