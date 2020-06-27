class AccessionUniquenessChecker < ApplicationForm
  def run
    GeneBank.where(accession_number: params[:query]).exists?
  end
end