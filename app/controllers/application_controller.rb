class ApplicationController < ActionController::API
  include Pundit
  include Renderer
  include Pagination
  include PreFilters
  include DeviseSanitizer
  include Pagy::Backend
  include ApiErrors::ErrorHandler
  include ActionController::Cookies
  include HttpAcceptLanguage::AutoLocale

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

end
