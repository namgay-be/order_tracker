class GeneBankAutoCompleteQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = ['accession_number'].freeze

  def run
    gene_bank_infos
      .then { |gene_bank_infos| search_by_attribute(gene_bank_infos) }
  end

  private

  def gene_bank_infos
    GeneBank.all
  end

  def search_by_attribute(gene_bank_infos)
    return gene_bank_infos if query.blank?

    gene_bank_infos.search_by_name(attribute_name, query)
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :accession_number
  end
end
