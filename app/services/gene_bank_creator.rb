class GeneBankCreator < ApplicationForm
  attr_accessor :gene_bank

  def create
    @gene_bank = GeneBank.new(params)
    @gene_bank.assign_attributes(creator: current_user)
    @gene_bank.transaction do
      @gene_bank.save && track_count && generate_accession_number && transfer_seed
    end
  end

  private

  def track_count
    PacketCount.create(
      gene_bank_id: gene_bank.id,
      germination_count: gene_bank.germination_weight,
      regeneration_count: gene_bank.regeneration_weight,
      rest_count: gene_bank.rest_weight,
      active_collection_count: gene_bank.active_collection_weight,
      characterization_count: gene_bank.characterization_weight,
      duplicate_count: gene_bank.duplicate_weight
    )
  end

  def generate_accession_number
    return unless gene_bank.accession_number.nil?

    gene_bank.update_column(:accession_number, "BTN#{seed.classification[0,3].upcase}#{seed.id}")
  end

  def transfer_seed
    seed.transfer!
  end

  def seed
    @seed ||= gene_bank.seed
  end
end