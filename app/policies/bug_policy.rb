# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  def create?
    @user.qa?
  end

  def new?
    @user.qa?
  end

  def edit?
    @user.qa?
  end

  def destroy?
    @user.qa?
  end

  def assign_developer?
    @user.developer?
  end

  def mark_resolved?
    @user.developer?
  end
end
