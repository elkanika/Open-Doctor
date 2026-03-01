# frozen_string_literal: true

class DeadlinePolicy < ApplicationPolicy
  def index?
    true
  end

  def mark_completed?
    update?
  end

  def mark_expired?
    update?
  end
end
