class UserDeleter < ApplicationForm
  attr_accessor :user

  def update(id)
    @user = User.find(id)
    authorize(user, :soft_delete?)
    @user.update(params)
  end
end
