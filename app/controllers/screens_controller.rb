class ScreensController < ApplicationController
  before_action :set_screen

  def show
    authorize(@screen)
    NarratorChannel.broadcast_to(current_user, render_to_string(partial: 'content'))
  end

  def notes
    @demo_session = current_user.demo_sessions.create(project: @screen.project, title: params['title'].presence || '[untitled]', created_at: params['start'].present? ? Time.at(params['start'].to_i / 1000) : DateTime.now) if @demo_session.nil?
    @note = @demo_session.notes.build(screen: @screen, title: @screen.title) if @note.nil?
    authorize(@note, :update?)
    if @note.content != params['notes'] && (params['notes'].present? || @note.persisted?)
      @note.update(content: params['notes'])
      @demo_session.touch
    end
    head :no_content
  end

  private

  def set_screen
    @screen = Screen.find(params['id'])
    @demo_session = current_user.demo_sessions.active.where(project: @screen.project).first
    @note = @demo_session.notes.where(screen: @screen).first if @demo_session
  end
end
