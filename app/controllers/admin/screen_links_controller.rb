module Admin
  class ScreenLinksController < BaseController
    before_action :set_screen, except: [:destroy]
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

    def destroy
      @screen_link = ScreenLink.find(params['id'])
      authorize(@screen_link)
      @screen_link.destroy!
      head :no_content
    end

    private

    def set_screen
      @screen = Screen.find(params['screen_id'])
      authorize(@screen, :edit?)
    end
  end
end
