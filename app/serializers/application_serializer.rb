class ApplicationSerializer < CacheCrispies::Base
  include Rails.application.routes.url_helpers
end
