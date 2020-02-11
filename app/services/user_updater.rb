class UserUpdater < ApplicationForm
  attr_accessor :user

  def update(id)
    @user = User.find(id)
    @user.update(params)
  end
end
