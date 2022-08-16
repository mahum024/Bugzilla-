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
end
