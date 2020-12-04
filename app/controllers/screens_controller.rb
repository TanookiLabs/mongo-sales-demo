class ScreensController < ApplicationController
  def show
    @screen = Screen.find(params['id'])
    authorize(@screen)
    NarratorChannel.broadcast_to(current_user, render_to_string(partial: 'content'))
  end
end
