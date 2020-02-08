class PasswordUpdater
  include ActiveModel::Validations

  attr_accessor(
    :params,
    :klass,
    :errors
  )

  def initialize(params, klass)
    @params = params
    @klass = klass
  end

  def update
    @errors = klass.reset_password_by_token(params).errors
    errors.empty?
  end
end
