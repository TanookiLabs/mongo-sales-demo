class ScreenDecorator < Draper::Decorator
  delegate_all

  def url
    h.screen_url(object)
  end
end
