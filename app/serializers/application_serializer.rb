class ApplicationSerializer < CacheCrispies::Base
  include Rails.application.routes.url_helpers

  def format_date(date)
    date&.strftime('%d/%m/%Y')
  end

  def format_time(time)
    time&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
