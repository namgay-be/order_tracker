class PasswordSetter
  attr_accessor(
    :resource_class,
    :resource_params,
    :errors
  )

  def initialize(resource_params, resource_class)
    @resource_params = resource_params
    @resource_class = resource_class
  end

  def save
    @errors = resource.errors
    @errors.empty?
  end

  def resource
    @resource ||= resource_class.send_reset_password_instructions(resource_params)
  end
end
