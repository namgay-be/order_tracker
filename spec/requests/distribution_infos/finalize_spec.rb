require 'rails_helper'

describe 'Distribution Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer, creator: admin) }
  let!(:seed) { create(:seed, creator: admin, seed_status: :transferred) }
  let!(:gene_bank) { create(:gene_bank, seed: seed, accession_number: 'BTNSeed89', creator: admin) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }
  let!(:distribution_info) {
    create(
      :distribution_info,
      customer: customer,
      seed: seed,
      package_type: 'duplicate',
      creator: admin
    )
  }

  let!(:customer_2) { create(:customer, name: 'namgay', cust_id: 'Cust_100', creator: admin) }
  let!(:seed_2) { create(:seed, creator: admin) }
  let!(:gene_bank_2) { create(:gene_bank, seed: seed_2, creator: admin) }
  let!(:active_collection_2) { create(:active_collection, gene_bank: gene_bank_2) }
  let!(:base_collection_2) { create(:base_collection, gene_bank: gene_bank_2) }
  let!(:location_2) { create(:location, locatable: base_collection_2) }
  let!(:characterization_2) { create(:characterization, gene_bank: gene_bank_2) }
  let!(:duplicate_2) { create(:duplicate, gene_bank: gene_bank_2) }
  let!(:distribution_info_2) {
    create(
      :distribution_info,
      customer: customer_2,
      seed: seed_2,
      creator: admin,
      purpose: 'ultimate purpose'
    )
  }
  let!(:params) do
    {
      distribution_info: {
        distribution_ids: [distribution_info.id, distribution_info_2.id]
      }
    }
  end

  it 'finalizes distributions' do
    post finalize_api_v1_distribution_infos_path, params: params, headers: header_params(token: token)
    expect(status).to eq(200)
    expect(DistributionInfo.all.pluck(:finalized).uniq).to eq([true])
  end
end
