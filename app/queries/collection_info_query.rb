class CollectionInfoQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
      collection_number
      mission_number
      collection_source
      collectors_name
      collection_note
      collection_date
     ].freeze

  def run
    collection_infos
      .yield_self { |collection_infos| search_by_attribute(collection_infos) }
  end

  private

  def search_by_attribute(collection_infos)
    return collection_infos if query.blank?

    collection_infos.search_by_name(attribute_name, query)
  end

  def collection_infos
    CollectionInfo.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :collection_number
  end
end
