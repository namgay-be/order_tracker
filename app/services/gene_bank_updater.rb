class GeneBankUpdater < ApplicationForm
  attr_accessor :gene_bank

  def update(id)
    @gene_bank = GeneBank.find(id)
    @gene_bank.update(params)
  end
end
