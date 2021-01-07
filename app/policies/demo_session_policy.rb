class DemoSessionPolicy < ApplicationPolicy
  def update?
    user&.superuser? || record.user == user
  end
end
