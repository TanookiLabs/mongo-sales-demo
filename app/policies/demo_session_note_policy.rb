class DemoSessionNotePolicy < ApplicationPolicy
  def update?
    user.present?
  end
end
