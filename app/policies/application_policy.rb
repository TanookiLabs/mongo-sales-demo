class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user&.superuser?
  end

  def show?
    user&.superuser?
  end

  def create?
    user&.superuser?
  end

  def new?
    create?
  end

  def update?
    user&.superuser?
  end

  def edit?
    update?
  end

  def destroy?
    user&.superuser?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
