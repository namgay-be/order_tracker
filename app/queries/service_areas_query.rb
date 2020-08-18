class ServiceAreasQuery < ApplicationQuery
  attr_accessor :query, :dzongkhag, :gewog, :village

  def run
    service_areas
      .then { |service_areas| fetch_by_dzongkhag(service_areas) }
      .then { |service_areas| fetch_by_gewog(service_areas) }
      .then { |service_areas| fetch_by_village(service_areas) }
      .then { |service_areas| search(service_areas)}
  end

  private

  def service_areas
    ServiceArea.includes(:address)
  end

  def fetch_by_dzongkhag(service_areas)
    return service_areas if dzongkhag.blank?

    service_areas.by_dzongkhag(dzongkhag)
  end

  def fetch_by_gewog(service_areas)
    return service_areas if gewog.blank?

    service_areas.by_gewog(gewog)
  end

  def fetch_by_village(service_areas)
    return service_areas if village.blank?

    service_areas.by_village(gewog)
  end

  def search(service_areas)
    return service_areas if query.blank?

    service_areas.search_by_name(query)
  end
end
