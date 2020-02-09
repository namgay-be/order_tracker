class ApplicationQuery
  FILTERS = %w[default].freeze

  attr_accessor(
    :current_user
  )

  def initialize(current_user:, params:)
    @current_user = current_user
    Hash(params).each do |key, value|
      writer_method = "#{key}="
      send(writer_method, value) if respond_to?(writer_method)
    end
  end
end
