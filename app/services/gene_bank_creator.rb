class GeneBankCreator < ApplicationForm
  attr_accessor :gene_bank

  def create
    @gene_bank = GeneBank.new(params)
    @gene_bank.save.tap do |result|
      result && track_count && generate_accession_number && transfer_seed
    end
  end

  private

  def track_count
    PacketCount.create(
      gene_bank_id: gene_bank.id,
      germination_count: gene_bank.germination_packets,
      regeneration_count: gene_bank.regeneration_packets,
      rest_count: gene_bank.rest_packets,
      active_collection_count: gene_bank.active_collection_packets,
      characterization_count: gene_bank.characterization_packets,
      duplicate_count: gene_bank.duplicate_packets
    )
  end

  def generate_accession_number
    return unless gene_bank.accession_number.nil?

    gene_bank.update_column(:accession_number, "BTNSeed#{seed.id}")
  end

  def transfer_seed
    seed.may_transfer? && seed.transfer!
  end

  def seed
    @seed ||= gene_bank.seed
  end
end