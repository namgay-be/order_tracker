require 'rails_helper'

describe 'Distribution Info', type: :request do
  let!(:admin) { create(:user, role_id: Role.first.id) }
  let!(:token) { user_token(admin) }
  let!(:customer) { create(:customer, creator: admin) }
  let!(:seed) { create(:seed, creator: admin, seed_status: :transferred) }
  let!(:gene_bank) { create(:gene_bank, seed: seed, creator: admin) }
  let!(:active_collection) { create(:active_collection, gene_bank: gene_bank) }
  let!(:base_collection) { create(:base_collection, gene_bank: gene_bank) }
  let!(:location_1) { create(:location, locatable: base_collection) }
  let!(:characterization) { create(:characterization, gene_bank: gene_bank) }
  let!(:duplicate) { create(:duplicate, gene_bank: gene_bank) }
  let!(:distribution_info) { create(
    :distribution_info,
    customer: customer,
    seed: seed,
    package_type: :duplicate,
    creator: admin
    )
  }

  it 'deletes a distribution info' do
    delete api_v1_distribution_info_path(distribution_info), params: {}, headers: header_params(token: token)
    expect(status).to eq(204)
    expect(seed.reload.duplicate.packets).to eq(20)
    expect(seed.duplicate.weight).to eq(30)
  end
end
