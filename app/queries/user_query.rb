class UserQuery < ApplicationQuery
  attr_accessor :role_filter, :query

  def run
    users
      .public_send(set_role_filter)
      .search(query)
  end

  private

  def users
    User.all
  end

  def set_role_filter
    role_filter.presence_in(Role.names.keys) || :all
  end
end
