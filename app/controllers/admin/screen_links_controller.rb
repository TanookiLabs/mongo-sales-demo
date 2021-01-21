module Admin
  class ScreenLinksController < BaseController
    before_action :set_screen, except: [:update, :destroy]
    before_action :set_screen_link, only: [:update, :destroy]
    skip_after_action :verify_policy_scoped

    def index; end

    def create
      link = @screen.links.build(
        destination_screen_id: params['screen'],
        coordinates: { top: params['top'], bottom: params['bottom'], left: params['left'], right: params['right'] }
      )

      if params['screen'].present?
        link.destination_screen_id = params['screen']
      else
        link.external_url = params['external_url']
      end

      link.save!

      render partial: 'link', locals: { link: link }
    end

    def update
      @screen_link.update(coordinates: { top: params['top'], bottom: params['bottom'], left: params['left'], right: params['right'] })
      head :no_content
    end

    def destroy
      @screen_link.destroy!
      head :no_content
    end

    private

    def set_screen
      @screen = Screen.find(params['screen_id'])
      authorize(@screen, :edit?)
    end

    def set_screen_link
      @screen_link = authorize(ScreenLink.find(params['id']))
    end
  end
end
