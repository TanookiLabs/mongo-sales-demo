class SalesItemDecorator < Draper::Decorator
  delegate_all

  def display_topic
    custom? ? topic : item_type_i18n
  end
end
