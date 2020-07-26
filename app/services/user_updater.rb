class UserUpdater < ApplicationForm
  attr_accessor :user

  def update(id)
    @user = User.find(id)
    authorize(user, :update?)
    alter_params unless (current_user == user)
    @user.update(params)
  end

  private

  def alter_params
    params.delete(:email)
  end
end
