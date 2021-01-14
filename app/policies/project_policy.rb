class ProjectPolicy < ApplicationPolicy
  def permitted_attributes
    [:title]
  end

  def show?
    user.present?
  end

  def duplicate?
    create?
  end
end
