# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def create?
    @user.manager?
  end

  def new?
    @user.manager?
  end

  def edit?
    @user.manager?
  end

  def destroy?
    @user.manager?
  end

  def add_developer_qa?
    @user.manager?
  end

  def add?
    @user.manager?
  end

  def remove?
    @user.manager?
  end
end
