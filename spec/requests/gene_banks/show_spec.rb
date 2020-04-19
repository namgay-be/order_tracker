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

  it 'fetches a gene bank record' do
    get api_v1_gene_bank_path(gene_bank), params: {}, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(json.dig(:gene_bank, :base_collection)).to be_present
    expect(json.dig(:gene_bank, :active_collection)).to be_present
    expect(json.dig(:gene_bank, :characterization)).to be_present
    expect(json.dig(:gene_bank, :duplicate)).to be_present
  end
end
