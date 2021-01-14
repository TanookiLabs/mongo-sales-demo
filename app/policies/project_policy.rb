class ProjectPolicy < ApplicationPolicy
  def permitted_attributes
    [:title]
  end

  def duplicate?
    create?
  end
end
