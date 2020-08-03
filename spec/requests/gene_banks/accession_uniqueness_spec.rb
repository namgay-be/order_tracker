require 'rails_helper'

describe 'GeneBank', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:seed) { create(:seed, creator: admin) }
  let!(:gene_bank) { create(:gene_bank, seed: seed, creator: admin) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }

  let!(:seed_2) { create(:seed, creator: admin) }
  let!(:gene_bank_2) { create(:gene_bank, seed: seed, creator: admin, accession_number: 'BTNSeed102') }
  let!(:active_collection_2) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection_2) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_2) { create(:location, locatable: base_collection) }
  let!(:characterization_2) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate_2) { create(:duplicate, gene_bank: gene_bank) }


  it 'checks if the accession number is already present or not' do
    get unique_accession_api_v1_gene_banks_path, params: { query: 'BTNSeed103'}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig('unique')).to eq(true)
  end

  it 'lists gene bank infos' do
    get auto_complete_api_v1_gene_banks_path, params: { query: 'BTNSeed102'}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig('gene_banks')).to be_present
  end
end
