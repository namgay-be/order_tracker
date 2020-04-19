class GeneBankCreator < ApplicationForm
  attr_accessor :gene_bank

  def create
    @gene_bank = GeneBank.new(params)
    @gene_bank.save.tap do |result|
      result && transfer_seed && generate_accession_number
    end
  end

  private

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