class ScreenPolicy < ApplicationPolicy
  def permitted_attributes
    [
      :title, :image_url, :root,
      sales_items_attributes: [:id, :topic, :content, :_destroy]
    ]
  end
end
