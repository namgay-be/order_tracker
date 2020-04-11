class RepatriationInfoQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
    repatriation_number
    repatriation_date
    quantity
    initial_germination_rate
    resistant
    susceptible
    condition
    donor_accession
    donor_name
    country
    organisation
    web_url
    email_id
    phone
    ].freeze

  def run
    repatriation_infos
      .yield_self { |repatriation_infos| search_by_attribute(repatriation_infos) }
  end

  private

  def search_by_attribute(repatriation_infos)
    return repatriation_infos if query.blank?

    repatriation_infos.search_by_name(attribute_name, query)
  end

  def repatriation_infos
    RepatriationInfo.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :repatriation_number
  end
end
