class StoresQuery < ApplicationQuery
  attr_accessor :query, :dzongkhag, :gewog, :village, :category

  def run
    stores
      .then { |stores| fetch_by_category(stores) }
      .then { |stores| fetch_by_dzongkhag(stores) }
      .then { |stores| fetch_by_gewog(stores) }
      .then { |stores| fetch_by_village(stores) }
      .then { |stores| search(stores)}
  end

  private

  def stores
    Store.includes(:address, :service_area, :photos)
  end

  def fetch_by_dzongkhag(stores)
    return stores if dzongkhag.blank?

    stores.by_dzongkhag(dzongkhag)
  end

  def fetch_by_gewog(stores)
    return stores if gewog.blank?

    stores.by_gewog(gewog)
  end

  def fetch_by_village(stores)
    return stores if village.blank?

    stores.by_village(village)
  end

  def fetch_by_category(stores)
    return stores if category.blank?

    stores.by_category(category)
  end

  def search(stores)
    return stores if query.blank?

    stores.search_by_name(query)
  end
end
