class ScreenPolicy < ApplicationPolicy
  def permitted_attributes
    [:title, :image_url, :root]
  end
end
