# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    same_studio?
  end

  def create?
    same_studio?
  end

  def new?
    create?
  end

  def update?
    same_studio? && (user.titular? || user.colaborador?)
  end

  def edit?
    update?
  end

  def destroy?
    same_studio? && user.titular?
  end

  private

  def same_studio?
    # Ensure the user belongs to the same studio as the record
    # If the record doesn't have a studio_id (like User), we check differently, 
    # but for most models acts_as_tenant ensures this. Just an extra layer.
    return true unless record.respond_to?(:studio_id)
    user.studio_id == record.studio_id
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
