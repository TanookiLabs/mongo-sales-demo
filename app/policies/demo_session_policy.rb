class DemoSessionPolicy < ApplicationPolicy
  def show?
    user&.superuser? || record.user == user
  end

  def update?
    user&.superuser? || record.user == user
  end
end
