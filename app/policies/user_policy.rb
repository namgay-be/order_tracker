class UserPolicy < ApplicationPolicy
  def index?
    current_user.role.admin?
  end

  def update?
    record == current_user || current_user.role.admin?
  end

  def soft_delete?
    current_user.role.admin?
  end
end
