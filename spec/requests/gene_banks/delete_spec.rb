require 'rails_helper'

describe 'GeneBank', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed) { create(:seed) }
  let!(:gene_bank) { create(:gene_bank, seed: seed) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }

  it 'deletes a gene bank record' do
    delete api_v1_gene_bank_path(gene_bank), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect { GeneBank.find(gene_bank.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end