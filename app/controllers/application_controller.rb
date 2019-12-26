class ApplicationController < ActionController::API
  include Pundit
  include Renderer
  include Pagination
  include PreFilters
  include Pagy::Backend
  include ApiErrors::ErrorHandler
  include ActionController::Cookies
  include HttpAcceptLanguage::AutoLocale
end
