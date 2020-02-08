class ApplicationForm
  include Assigner
  include Pundit

  attr_accessor(
    :current_user,
    :params
  )

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def save
    raise NotImplementedError
  end
end
